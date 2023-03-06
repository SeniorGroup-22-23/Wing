//
//  MessageView.swift
//  Wing
//
//  Created by Ankita Menon on 2023-01-28.
//

import SwiftUI

struct Matches: Hashable {
    let id: Int
    let name: String
    let photo: String
    var new: Bool
    let number: String
    var numberSent: Bool
    
}

//TODO: to be replaced later with real profiles from the database
var profiles: [Matches] = [
    Matches(id: 1, name: "Mike", photo: "", new: false, number: "+1 (506) 123-1234", numberSent: true),
    Matches(id: 2, name: "Colin", photo: "", new: true, number: "+1 (506) 123-1234", numberSent: false),
    Matches(id: 3, name: "Kathy", photo: "", new: true, number: "+1 (506) 123-1234", numberSent: false),
    Matches(id: 4, name: "Jake", photo: "", new: false, number: "+1 (506) 123-1234", numberSent: true),
    Matches(id: 5, name: "Hannah", photo: "", new: true, number: "+1 (876) 123-1234", numberSent: false),
    Matches(id: 6, name: "Sarah", photo: "", new: false, number: "+1 (506) 123-1234", numberSent: false),
    Matches(id: 7, name: "Nina", photo: "", new: true, number: "+1 (506) 123-1234", numberSent: true),
    Matches(id: 8, name: "Josh", photo: "", new: true, number: "+1 (506) 123-1234", numberSent: true),
    Matches(id: 9, name: "Drake", photo: "", new: false, number: "+1 (506) 123-1234", numberSent: false),
    Matches(id: 10, name: "Kylie", photo: "", new: false, number: "+1 (886) 123-1234", numberSent: false)
]

//Filters the profiles array into two diffferent arrays
var matches = profiles.filter { $0.numberSent == false }
var numbers = profiles.filter { $0.numberSent == true }

struct MessageView: View {
    var body: some View {
        NavigationView {
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
    @State private var selectedMatch: Matches?
    @State var sortedMatches = matches.sorted{$0.new && !$1.new }
    
    var body : some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: layout, spacing: 65){
                ForEach(0..<sortedMatches.count, id:\.self) { match in
                    NavigationLink(destination: RepliesView(numberChosen: $sortedMatches[match]), tag: sortedMatches[match], selection: $selectedMatch) {
                        VStack{
                            if (sortedMatches[match].new == true){
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
                            Text(sortedMatches[match].name)
                                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                                .foregroundColor(Color("DarkGreen"))
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        sortedMatches = sortedMatches.sorted{$0.new && !$1.new } //resorts the list
                    })
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
    @State private var selectedNumber: Matches?
    @State var sortedNumbers = numbers.sorted{$0.new && !$1.new }
    
    var body : some View {
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(0..<sortedNumbers.count, id: \.self){ number in
                    NavigationLink(destination: RepliesView(numberChosen: $sortedNumbers[number]), tag: sortedNumbers[number], selection: $selectedNumber) {
                        VStack{
                            Circle()
                                .fill(.white)
                                .frame(width: 60, height: 60)
                                .padding(.horizontal, 20)
                            HStack{
                                Text(sortedNumbers[number].name)
                                    .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                                    .foregroundColor(Color("DarkGreen"))
                                if (sortedNumbers[number].new == true){
                                    Circle()
                                        .fill(Color("BrightBlue"))
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        sortedNumbers = sortedNumbers.sorted{$0.new && !$1.new } //resorts the list
                    })
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
