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

let numbers: [Match] = [
    Match(name: "Mike", photo: "", new: false),
    Match(name: "Colin", photo: "", new: true),
    Match(name: "Kathy", photo: "", new: false),
    Match(name: "Jake", photo: "", new: false),
    Match(name: "Hannah", photo: "", new: true)
]

let sortedNumbers = numbers.sorted{$0.new && !$1.new }


struct MessageView: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            
            VStack {
                HeaderTab() // wing symbol and settings button
                    .frame(width: 380)
                    .offset(y: 50)
                LoadMatchesBox() // this section shows matches
                LoadNumbersBox() // this section shows replies
                    .offset(y: -60)
                FooterTab() // wing symbol, match symbol, and messages symbol
                    .frame(width: 300)
                    .offset(y: -40)
            }
        }
    }
}

struct PhoneBookText: View {
    var body: some View {
        Text("Phone Book")
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
                if ((matches.count) == 0){
                    Spacer()
                        .frame(height: 150)
                    LoadNoMatchesText()
                        .background(BackgroundLogo())
                    Spacer()
                        .frame(height: 300)
                }
                else{
                    LoadMatchProfiles()
                }
            }
        }
    }
}

let layout = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
]

struct LoadMatchProfiles : View {
    var body : some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: layout, spacing: 65){
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
                            .frame(width: 80, height: 80)
                            .padding(.horizontal, 20)
                        Text(match.name)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                            .foregroundColor(Color("DarkGreen"))
                    }
                }
            }
        }
        .frame(width: 300, height: 480)
        .offset(y: -40)
    }
}

struct LoadNumbersBox : View {
    var body : some View {
        ZStack{
            VStack{
                PhoneBookText()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20.0)
                if ((numbers.count) == 0){
                    Spacer()
                        .frame(height: 100)
                }
                else{
                    ZStack{
                        Rectangle()
                            .fill(Color(.white).opacity(0.7))
                            .frame(width: 337, height: 120)
                            .cornerRadius(10)
                            .offset(y: -10)
                        LoadNumberProfiles()
                    }
                    
                }
            }
        }
    }
}

struct LoadNumberProfiles : View {
    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
                ForEach(sortedNumbers, id:\.name) { number in
                    VStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                            .padding(.horizontal, 20)
                        HStack{
                            Text(number.name)
                                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                                .foregroundColor(Color("DarkGreen"))
                            if (number.new == true){
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
