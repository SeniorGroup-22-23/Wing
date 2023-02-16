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
    @ObservedObject var signupViewModel: SignupViewModel = .method
    @ObservedObject var matchViewModel: MatchViewModel = .method
    @StateObject var potentialMatch = PotentialMatch(name: "Nury", age: 23, occupation: "Software Engineering", bio: "This is my bio! I am a student at UNB and I can't wait to use the Wing app. Woohoo!", prompts: ["What's your favourite sport?", "Who's your celeb crush?", ""], answers: ["Football. Can't wait for the superbowl!!", "Probably Brad Pitt..", ""], photos: [Image?](repeating : nil, count : 8), wing: false)
    
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
                    
                    }
                    .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
                        .onEnded({ value in
                            let horizontalAmount = value.translation.width
                            let verticalAmount = value.translation.height
                            if abs(verticalAmount) > abs(horizontalAmount) {
                                print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                
                                Task {
                                    let tempNewProspect = await getProspect()
                                    
                                    potentialMatch.name = tempNewProspect?.name ?? ""
                                    potentialMatch.age = tempNewProspect?.age ?? -1
                                    potentialMatch.occupation = tempNewProspect?.occupation ?? ""
                                    potentialMatch.bio = tempNewProspect?.bio ?? ""
                                    potentialMatch.prompts = tempNewProspect?.prompts ?? ["", "", ""]
                                    potentialMatch.answers = tempNewProspect?.answers ?? ["", "", ""]
                                    potentialMatch.photos = tempNewProspect?.photos ?? [Image?](repeating : nil, count : 8)
                                    potentialMatch.wing = tempNewProspect?.wing ?? false
                                }
                            }
                        })
                    )
                    .onChange(of: potentialMatch.name) { _ in
                        value.scrollTo(0, anchor: .trailing)
                    }
                }
                .environmentObject(potentialMatch)
                
                FooterTab()
            }
            .onAppear {
                Task {
                    if let unwrappedID = signupViewModel.user.id {
                        matchViewModel.setUser(userID: unwrappedID)
                    }
                    try await matchViewModel.getProspects()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func getProspect() async -> PotentialMatch? {
        let idList = matchViewModel.prospectID
        
        do {
            try await matchViewModel.loadProspectProfile(prospectID : idList[0])
        } catch {
            print("Can't load prospect profile. Error: \(error)")
        }
        
        let profile = matchViewModel.prospectProfile
        
        return PotentialMatch(name: profile.name ?? "", age: profile.birthdate?.age ?? -1, occupation: profile.occupation ?? "", bio: profile.bio ?? "", prompts: ["prompt 1", "prompt 2", ""], answers: ["answer 1", "answer 2", ""], photos: [Image?](repeating : nil, count : 8), wing: false)
    }
}

struct LoadNextUser : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        HStack {
            VStack {
                (Text(user.name) + Text(", ") + Text(String(user.age)))
                    .font(.custom(FontManager.NotoSans.semiBold, size : 28.0))
                    .offset(x : 15)
                Text(user.occupation)
                    .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                    .offset(x: 40)
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

struct LoadSlides : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        fullImage(image: user.photos[0])
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
                        VStack {
                            splitImage(image: user.photos[i+2])
                            splitText(prompt: user.prompts[i], ans: user.answers[i])
                        }
                    } else {
                        VStack {
                            splitText(prompt: user.prompts[i], ans: user.answers[i])
                            splitImage(image: user.photos[i+2])
                        }
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
