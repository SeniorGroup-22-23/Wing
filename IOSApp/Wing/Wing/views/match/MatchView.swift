//
//  MatchView.swift
//  Wing
//
//  Created by Nury Kim on 2022-12-02.
//

import SwiftUI

class PotentialMatch : ObservableObject {
    @Published var name : String = ""
    @Published var age : Int = 0
    @Published var occupation : String = ""
    @Published var bio : String = ""
    @Published var prompts : [String] = ["", "", ""]
    @Published var answers : [String] = ["", "", ""]
    @Published var photos : [Image?] = [Image?](repeating : nil, count : 8)
}

struct MatchView: View {
    @StateObject var potentialMatch = PotentialMatch()
    
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
