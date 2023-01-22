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
    
    init(name : String, age : Int, occupation : String, bio : String, prompts : [String], answers : [String], photos : [Image?]) {
        self.name = name
        self.age = age
        self.occupation = occupation
        self.bio = bio
        self.prompts = prompts
        self.answers = answers
        self.photos = photos
    }
}

class showBlock: ObservableObject {
    @Published var blockAlert = false
    @Published var reportAlert = false
}

struct MatchView: View {
    @StateObject var showingBlockAlert = showBlock()
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    @StateObject var potentialMatch = PotentialMatch(name: "Nury", age: 23, occupation: "Software Engineering", bio: "This is my bio! I am a student at UNB and I can't wait to use the Wing app. Woohoo!", prompts: ["What's your favourite sport?", "Who's your celeb crush?", ""], answers: ["Football. Can't wait for the superbowl!!", "Probably Brad Pitt..", ""], photos: [Image?](repeating : nil, count : 8))
    
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                HeaderTab()
                
                VStack {
                    LoadNextUser()
                    
                    ScrollView(.horizontal) {
                        HStack {
                            LoadSlides()
                        }
                        .padding(.leading)
                    }
                }
                .onLongPressGesture {
                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                        ModalPopUpView(showingBlockAlert: showingBlockAlert)
                                }
                }
                .alert(isPresented:$showingBlockAlert.blockAlert) {
                    Alert(
                        title: Text("Block this user?"),
                        message: Text("We want to ensure a safe and supportive user experience at Wing. Block any user that you would not like to see on the app."),
                        primaryButton: .destructive(Text("Block")) {
                            print("Blocking...")
                        },
                        secondaryButton: .cancel()
                    )
                }
                .alert(isPresented:$showingBlockAlert.reportAlert) {
                    Alert(
                        title: Text("Your report has been submitted and will be reviewed."),
                        message: Text("Thank you for keeping Wing safe."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
                    .onEnded({ value in
                        let horizontalAmount = value.translation.width
                        let verticalAmount = value.translation.height
                        if abs(verticalAmount) > abs(horizontalAmount) {
                            print(verticalAmount < 0 ? "up swipe" : "down swipe")
                            
                            potentialMatch.name = "Nury"
                            potentialMatch.age = 23
                            potentialMatch.occupation = "Software Engineer"
                            potentialMatch.bio = "Hey this is my bio!"
                            potentialMatch.prompts = ["Who's your celeb crush?", "What's your favourite sport?", "What's your favourite animal?"]
                            potentialMatch.answers = ["Brad Pitt", "Football!!", "dogsss"]
                        }
                    })
                )
                .environmentObject(potentialMatch)
                
                FooterTab()
            }
        }
    }
}

struct LoadNextUser : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        HStack {
            (Text(user.name) + Text(", ") + Text(String(user.age)))
                .font(.custom(FontManager.NotoSans.semiBold, size : 28.0))
            Spacer()
        }
            .offset(x : 30)
        
        HStack {
            Text(user.occupation)
                .font(.custom(FontManager.NotoSans.regular, size : 15.0))
            Spacer()
        }
            .offset(x : 40)
    }
}

struct LoadSlides : View {
    @EnvironmentObject var user : PotentialMatch
    
    var body : some View {
        fullImage(image: user.photos[0])
        
        if (user.bio == "") {
            fullImage(image: user.photos[1])
        } else {
            VStack {
                splitText(prompt: "", ans: user.bio)
                splitImage(image: user.photos[1])
            }
                .padding(.trailing)
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
                    .padding(.trailing)
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
