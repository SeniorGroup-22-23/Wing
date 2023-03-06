//
//  WingFeatureView.swift
//  Wing
//
//  Created by Ankita Menon on 29/11/2022.
//

import SwiftUI

struct WingedProfiles{
    let name: String
    let age: Int
    let photo: String
    let wingSent: String
    let wingmanPhoto: String
}

//TODO: Replace this list with real winged profiles after endpoint implementation
let profiles: [WingedProfiles] = [
    WingedProfiles(name: "Aubrey", age: 32, photo: "", wingSent: "Mike", wingmanPhoto: ""),
    WingedProfiles(name: "Joe", age: 29, photo: "", wingSent: "Colin", wingmanPhoto: ""),
    WingedProfiles(name: "Kait", age: 24, photo: "", wingSent: "Mike", wingmanPhoto: ""),
    WingedProfiles(name: "Mark", age: 30, photo: "", wingSent: "Mike", wingmanPhoto: ""),
    WingedProfiles(name: "Nancy", age: 26, photo: "", wingSent: "Colin", wingmanPhoto: ""),
    WingedProfiles(name: "Bob", age: 28, photo: "", wingSent: "Colin", wingmanPhoto: ""),
    WingedProfiles(name: "Walter", age: 22, photo: "", wingSent: "Mike", wingmanPhoto: ""),
    WingedProfiles(name: "Nina", age: 36, photo: "", wingSent: "Colin", wingmanPhoto: ""),
    WingedProfiles(name: "Wayne", age: 40, photo: "", wingSent: "Colin", wingmanPhoto: ""),
    WingedProfiles(name: "Brandon", age: 30, photo: "", wingSent: "Mike", wingmanPhoto: "")
]

struct WingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("MainGreen")
                    .ignoresSafeArea()
                VStack {
                    HeaderTab()
                        .offset(y: 15)
                        .frame(width: 380)
                    LoadWingBox()
                        .frame(height: 500)
                        .offset(y: -25)
                    LoadFriendsBox()
                        .offset(y: -15)
                    FooterTab()
                        .offset(y: -7)
                        .frame(width: 300)
                }
            }
        }
    }
}

struct LoadWaitMessage : View {
    var body : some View {
        VStack{
            Text("Waiting for your response...")
                .font(.custom(FontManager.NotoSans.bold, size: 16.0))
                .foregroundColor(Color("DarkGreen"))
                .frame(width: 315, alignment: .leading)
                .offset(y: -190)
        }
    }
}

struct LoadFriendHeader : View {
    var body : some View {
        HStack{
            Text("Friends")
                .font(.custom(FontManager.NotoSans.bold, size: 16.0))
                .foregroundColor(Color("DarkGreen"))
                .frame(width: 250, alignment: .leading)
                
            NavigationLink(destination: FriendsView()) {
                Text("Edit")
                    .font(.custom(FontManager.NotoSans.bold, size: 10.0))
                    .foregroundColor(Color(.white))
                    .frame(width: 48, height: 17)
                    .background(Color("DarkGreen"))
                    .cornerRadius(10)
            }
        }
        .offset(y: -10)
    }
}

struct LoadNoWingsText : View {
    var body : some View {
        VStack{
            Text("Nothing to see here...")
                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
            Text("""
                When a friend sends you a
                profile, you will be able to view
                them here.
                """)
                .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
                .offset(y: 15)
        }
    }
}

struct LoadNoFriendsText : View {
    var body : some View {
        VStack{
            Text("No friends yet")
                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
            Text("Add friends to grow your friend list.")
                .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
                .offset(y: 5)
        }
    }
}

struct BackgroundLogo: View {
    var body: some View {
        Image("GreenLogo")
            .padding(.trailing)
            .frame(width: 200, height: 400)
            .opacity(0.2)
    }
}

struct LoadFriendsProfiles : View {
    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
                ForEach(friends, id:\.name) { friend in
                    VStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Text(friend.name)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 10.0))
                            .foregroundColor(Color("DarkGreen"))
                        Text("@\(friend.username)")
                            .font(.custom(FontManager.NotoSans.regular, size: 10.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 90)
                    }
                }
            }
        }
        .frame(width: 300, height: 90)
    }
}

struct LoadWingBox : View {
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.white).opacity(0.7))
                .frame(width: 337, height: 520)
                .cornerRadius(10)
            VStack{
                if ((profiles.count) == 0){
                    LoadWaitMessage()
                    LoadNoWingsText()
                }
                else {
                    ProfilesGridView()
                        .offset(y: 70)
                    LoadWaitMessage()
                        .offset(y: -395)
                }
            }
        }
        .frame(height: 700)
        .background(BackgroundLogo())
    }
}

struct LoadFriendsBox : View {
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.white).opacity(0.7))
                .frame(width: 337, height: 120)
                .cornerRadius(10)
            VStack{
                if ((friends.count) == 0){
                    LoadFriendHeader()
                    LoadNoFriendsText()
                }
                else{
                    LoadFriendHeader()
                        .offset(y: 20)
                    LoadFriendsProfiles()
                }
            }
        }
    }
}

struct WingView_Previews: PreviewProvider {
    static var previews: some View {
        WingView()
    }
}


