//
//  MatchView.swift
//  Wing
//
//  Created by Nury Kim on 2022-12-02.
//

import SwiftUI

class PotentialMatch : ObservableObject {
    @Published var name : String
    @Published var age : Int
    @Published var occupation : String
    @Published var bio : String
    @Published var prompts : [String]
    @Published var answers : [String]
    @Published var photos : [Image?]
    @Published var wing : Bool
    
    init(name : String, age : Int, occupation : String, bio : String, prompts : [String], answers : [String], photos : [Image?], wing : Bool) {
        self.name = name
        self.age = age
        self.occupation = occupation
        self.bio = bio
        self.prompts = prompts
        self.answers = answers
        self.photos = photos
        self.wing = wing
    }
}

struct MatchView: View {
    @State private var numProspects = 0
    @State private var matchPopUp = false
    @ObservedObject var signupViewModel: SignupViewModel = .method
    @ObservedObject var matchViewModel: MatchViewModel = .method
    @StateObject var potentialMatch = PotentialMatch(name: "", age: -1, occupation: "", bio: "", prompts: ["", "", ""], answers: ["", "", ""], photos: [Image?](repeating : nil, count : 8), wing: false)

    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                HeaderTab()
                
                ScrollViewReader { value in
                    VStack {
                        LoadNextUser()
                    
                        ScrollView(.horizontal) {
                            HStack {
                                LoadSlides()
                            }
                            .padding(.leading)
                            .padding(.trailing)
                        }
                        .popover(isPresented: $matchPopUp) {
                            Text("It's a match")
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
                        .onEnded({ value in
                            let horizontalAmount = value.translation.width
                            let verticalAmount = value.translation.height
                            if abs(verticalAmount) > abs(horizontalAmount) {
                                print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                
                                Task {
                                    // first get ready to post swipe by intializing the proper attributes in the viewmodel
                                    
                                    if (verticalAmount < 0) {
                                        // up swipe
                                        matchViewModel.swipeType = 1
                                    } else {
                                        // down swipe
                                        matchViewModel.swipeType = 2
                                    }
                                    
                                    try await matchViewModel.postSwipe()
                                    
                                    if (matchViewModel.match) {
                                        matchPopUp = true
                                    }
                                }
                                
                                Task {
                                    // get the next prospect's profile
                                    let tempNewProspect = await getProspect()
                                    
                                    potentialMatch.name = tempNewProspect?.name ?? ""
                                    potentialMatch.age = tempNewProspect?.age ?? -1
                                    potentialMatch.occupation = tempNewProspect?.occupation ?? ""
                                    potentialMatch.bio = tempNewProspect?.bio ?? ""
                                    potentialMatch.prompts = tempNewProspect?.prompts ?? ["", "", ""]
                                    potentialMatch.answers = tempNewProspect?.answers ?? ["", "", ""]
                                    potentialMatch.photos = tempNewProspect?.photos ?? [Image?](repeating : nil, count : 8)
                                    potentialMatch.wing = matchViewModel.wingLikeProspect
                        
                                }
                            }
                        })
                    )
                    .onChange(of: potentialMatch.name) { _ in
                        value.scrollTo(0, anchor: .trailing)
                    }
                }
                CheckNoProspects()
                
                FooterTab()
            }
            .onAppear {
                Task {
                    if let unwrappedID = signupViewModel.user.id {
                        matchViewModel.primaryUserId = unwrappedID
                    }
                    try await matchViewModel.getProspects()
                    
                    let firstProspect = await getProspect()
                    
                    potentialMatch.name = firstProspect?.name ?? ""
                    potentialMatch.age = firstProspect?.age ?? -1
                    potentialMatch.occupation = firstProspect?.occupation ?? ""
                    potentialMatch.bio = firstProspect?.bio ?? ""
                    potentialMatch.prompts = firstProspect?.prompts ?? ["", "", ""]
                    potentialMatch.answers = firstProspect?.answers ?? ["", "", ""]
                    potentialMatch.photos = firstProspect?.photos ?? [Image?](repeating : nil, count : 8)
                    
                    // testing purposes for image
                    /*
                    let profilePreview = matchViewModel.prospectProfilePreview
                    let photoData = profilePreview.primaryPhoto!
                    let photoUIimage = UIImage(data : photoData)!
                    potentialMatch.photos[0] = Image(uiImage: photoUIimage)
                    */
                    
                    potentialMatch.wing = firstProspect?.wing ?? false
                }
            }
            .environmentObject(potentialMatch)
        }.navigationBarBackButtonHidden(true)
        
    }
    
    func getProspect() async -> PotentialMatch? {
        let idList = self.matchViewModel.prospectID
        
        var firstPrompt = ""
        var secondPrompt = ""
        var thirdPrompt = ""
        
        var firstResponse = ""
        var secondResponse = ""
        var thirdResponse = ""
        
        if (numProspects < idList.count) {
            // First get the profile of the prospect to show
            do {
                try await self.matchViewModel.loadProspectProfile(prospectID : idList[numProspects])
                matchViewModel.swipeProspectID = matchViewModel.prospectProfile.userId!
                numProspects += 1
            } catch {
                print("Can't load prospect profile. Error: \(error)")
            }
            
            // Then get the prompt responses of the prospect
            do {
                try await self.matchViewModel.getPromptResponses(prospectID: self.matchViewModel.prospectProfile.userId!)
                let promptResponses = self.matchViewModel.promptResponses
                
                if (promptResponses.count >= 1) {
                    try await self.matchViewModel.getPrompt(promptID: promptResponses[0].promptId!)
                    
                    firstPrompt = self.matchViewModel.prompt.promptText ?? ""
                    firstResponse = promptResponses[0].responseText ?? ""
                }
                
                if (promptResponses.count >= 2) {
                    try await self.matchViewModel.getPrompt(promptID: promptResponses[1].promptId!)
                    
                    secondPrompt = self.matchViewModel.prompt.promptText ?? ""
                    secondResponse = promptResponses[1].responseText ?? ""
                }
                
                if (promptResponses.count == 3) {
                    try await self.matchViewModel.getPrompt(promptID: promptResponses[2].promptId!)
                    
                    thirdPrompt = self.matchViewModel.prompt.promptText ?? ""
                    thirdResponse = promptResponses[2].responseText ?? ""
                }
                
                // check if it's a wing like
                try await matchViewModel.checkWingLike()
                
            } catch {
                print("Can't get user's prompts. Error: \(error)")
            }
            
            let profile = self.matchViewModel.prospectProfile
            
//            do {
//                try await self.matchViewModel.loadProspectPreview()
//            } catch {
//                print("Can't get user's photos. Error: \(error)")
//            }
            
            return PotentialMatch(name: profile.name ?? "", age: profile.birthdate?.age ?? -1, occupation: profile.occupation ?? "", bio: profile.bio ?? "", prompts: [firstPrompt, secondPrompt, thirdPrompt], answers: [firstResponse, secondResponse, thirdResponse], photos: [Image?](repeating : nil, count : 8), wing: false)
        }
        
        return PotentialMatch(name: "", age: -1, occupation: "", bio: "", prompts: ["", "", ""], answers: ["", "", ""], photos: [Image?](repeating : nil, count : 8), wing: false)
    }
}

struct LoadNextUser : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        if (user.name != "") {
            HStack {
                VStack {
                    (Text(user.name) + Text(", ") + Text(String(user.age)))
                        .font(.custom(FontManager.NotoSans.semiBold, size : 28.0))
                        .offset(x : 15)
                    Text(user.occupation)
                        .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                        .offset(x: 30)
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                if (user.wing) {
                    Image("WingMatchBadge")
                        .resizable()
                        .frame(width: 75.0, height: 75.0)
                }
                Spacer()
            }
        }
    }
}

struct CheckNoProspects : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        if (user.name == "") {
            NoProspectsMatchView()
        }
    }
}

struct LoadSlides : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        if (user.name != "") {
            user.photos[0]
                .id(0)
            if (user.bio == "") {
                fullImage(image: user.photos[1])
            } else {
                VStack {
                    splitText(prompt: "", ans: user.bio)
                    splitImage(image: user.photos[1])
                }
            }
            
            ForEach (0..<3) { i in
                if (user.photos[i+2] == nil) {
                    if (user.prompts[i] != "" && user.answers[i] != "") {
                        if (i % 2 == 0) {
                            imageTop(num: i)
                        } else {
                            imageBtm(num: i)
                        }
                    } else {
                        fullImage(image: user.photos[i+2])
                    }
                } else {
                    if (user.prompts[i] != "" && user.answers[i] != "") {
                        fullText(prompt: user.prompts[i], ans: user.answers[i])
                    }
                }
            }
            
            ForEach (5..<8) { i in
                if (user.photos[i] == nil) {
                    fullImage(image: user.photos[i])
                }
            }
        }
    }
    
    func imageTop(num : Int) -> some View {
        VStack {
            splitImage(image: user.photos[num+2])
            splitText(prompt: user.prompts[num], ans: user.answers[num])
        }
    }
    
    func imageBtm(num : Int) -> some View {
        VStack {
            splitText(prompt: user.prompts[num], ans: user.answers[num])
            splitImage(image: user.photos[num+2])
        }
    }
    
    func fullImage(image : Image?) -> some View {
        // TODO : change to image once endpoints ready
        return Rectangle()
                .fill(Color("DarkGreen"))
                .frame(width : 360, height : 475)
                .cornerRadius(10)
    }
    
    func fullText(prompt : String, ans : String) -> some View {
        return ZStack {
            VStack {
                Text(prompt)
                    .font(.custom(FontManager.KumbhSans.semiBold, size : 20.0))

                Text(ans)
                    .font(.custom(FontManager.NotoSans.regular, size : 15.0))
            }
        }
            .frame(width : 360, height : 475)
            .background(.white.opacity(0.3))
            .cornerRadius(10)
    }
    
    func splitText(prompt : String, ans : String) -> some View {
        return ZStack {
            VStack {
                if (prompt != "") {
                    Text(prompt)
                        .font(.custom(FontManager.KumbhSans.semiBold, size : 20.0))
                }
                
                Text(ans)
                    .font(.custom(FontManager.NotoSans.regular, size : 15.0))
            }
        }
            .frame(width : 360, height : 120)
            .background(.white.opacity(0.3))
            .cornerRadius(10)
    }
    
    func splitImage(image : Image?) -> some View {
        // TODO : change to image once endpoints ready
        return Rectangle()
            .fill(Color("DarkGreen"))
                .frame(width : 360, height : 345)
                .cornerRadius(10)
    }
}


struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}

extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
