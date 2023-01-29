//
//  MessageView.swift
//  Wing
//
//  Created by Nury Kim on 2023-01-17.
//

import SwiftUI

struct Match {
    let name: String
    let photo: String
    let new: Bool
}

let matches: [Match] = [
    Match(name: "Mike", photo: "", new: false),
    Match(name: "Colin", photo: "", new: true),
    Match(name: "Kathy", photo: "", new: false),
    Match(name: "Jake", photo: "", new: false),
    Match(name: "Hannah", photo: "", new: true)
]

let sortedMatches = matches.sorted{$0.new && !$1.new }

let replies: [Match] = [
    Match(name: "Mike", photo: "", new: false),
    Match(name: "Colin", photo: "", new: true),
    Match(name: "Kathy", photo: "", new: false),
    Match(name: "Jake", photo: "", new: false),
    Match(name: "Hannah", photo: "", new: true)
]

let sortedReplies = replies.sorted{$0.new && !$1.new }

let requests: [Match] = [
    Match(name: "Mike", photo: "", new: false),
    Match(name: "Colin", photo: "", new: true),
    Match(name: "Kathy", photo: "", new: false),
    Match(name: "Jake", photo: "", new: false),
    Match(name: "Hannah", photo: "", new: true)
]

let sortedRequests = requests.sorted{$0.new && !$1.new }

struct MessageView: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            
            VStack {
                HeaderTab() // wing symbol and settings button
                    .frame(width: 380)
                LoadMatchesBox() // this section shows matches
                    .frame(height: 250)
                    .offset(y: -50)
                LoadRepliesBox() // this section shows replies
                LoadRequestsBox() // this section shows phone requests
                FooterTab() // wing symbol, match symbol, and messages symbol
                    .frame(width: 300)
            }
        }
    }
}

struct RepliesText: View {
    var body: some View {
        Text("Replies")
            .foregroundColor(.white)
            .font(.custom(FontManager.NotoSans.semiBold, size: 28.0))
    }
}

struct MatchesText: View {
    var body: some View {
        Text("Matches")
            .foregroundColor(.white)
            .font(.custom(FontManager.NotoSans.semiBold, size: 28.0))
    }
}

struct RequestsText: View {
    var body: some View {
        Text("Requests")
            .foregroundColor(.white)
            .font(.custom(FontManager.NotoSans.semiBold, size: 28.0))
    }
}

struct LoadNoMatchesText : View {
    var body : some View {
        VStack{
            Text("No matches yet...")
                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
            Text("Start swiping to match!")
                .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
                .offset(y: 15)
        }
    }
}
//TODO: can be removed once merged into main
struct BackgroundLogo: View {
    var body: some View {
        Image("GreenLogo")
            .padding(.trailing)
            .frame(width: 200, height: 400)
            .opacity(0.2)
    }
}

struct LoadMatchesBox : View {
    var body : some View {
        ZStack{
            VStack{
                MatchesText()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20.0)
                    .offset(y: 50)
                if ((matches.count) == 0){
                    Spacer()
                        .frame(height: 150)
                    LoadNoMatchesText()
                        .background(BackgroundLogo())
                }
                else{
                    LoadMatchProfiles()
                }
            }
        }
    }
}

let layout = [
    GridItem(.adaptive(minimum: 100)),
]

struct LoadMatchProfiles : View {
    var body : some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: layout){
                ForEach(sortedMatches, id:\.name) { match in
                    VStack{
                        if (match.new == true){
                            Text("New!")
                                .font(.custom(FontManager.NotoSans.semiBold, size: 15.0))
                                .offset(y: 10)
                                .foregroundColor(Color(red: 1, green: 0.8, blue: 0.2))
                            
                        }
                        else{
                            Text("")
                                .font(.custom(FontManager.NotoSans.semiBold, size: 15.0))
                                .padding(.vertical, 5)
                        }
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                            .padding(.horizontal, 20)
                        Text(match.name)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                            .foregroundColor(Color("DarkGreen"))
                    }
                }
            }
        }
        .frame(width: 310, height: 280)
        .offset(y: 20)
    }
}

struct LoadRepliesBox : View {
    var body : some View {
        ZStack{
            VStack{
                RepliesText()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20.0)
                if ((replies.count) == 0){
                   Spacer()
                }
                else{
                    LoadRepliesProfiles()
                }
            }
        }
    }
}

struct LoadRepliesProfiles : View {
    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
                ForEach(sortedReplies, id:\.name) { reply in
                    VStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                            .padding(.horizontal, 20)
                        HStack{
                            Text(reply.name)
                                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                                .foregroundColor(Color("DarkGreen"))
                            if (reply.new == true){
                                Circle()
                                    .fill(Color("BrightBlue"))
                                    .frame(width: 15, height: 15)
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 310, height: 110)
    }
}

struct LoadRequestsBox : View {
    var body : some View {
        ZStack{
            VStack{
                RequestsText()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20.0)
                if ((requests.count) == 0){
                   Spacer()
                }
                else{
                    LoadRequestsProfiles()
                }
            }
        }
    }
}

struct LoadRequestsProfiles : View {
    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
                ForEach(sortedRequests, id:\.name) { request in
                    VStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                            .padding(.horizontal, 20)
                        HStack{
                            Text(request.name)
                                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                                .foregroundColor(Color("DarkGreen"))
                            if (request.new == true){
                                Circle()
                                    .fill(Color("BrightBlue"))
                                    .frame(width: 15, height: 15)
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 310, height: 110)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
