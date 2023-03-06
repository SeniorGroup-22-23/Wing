//
//  FriendsView.swift
//  Wing
//
//  Created by Ankita Menon on 30/11/2022.
//

import SwiftUI


//TODO: Replace this list with real profiles after endpoint implementation
let potentialFriends: [Friend] = [
    Friend(name: "Sasha", username: "sashawing", photo: ""),
    Friend(name: "Mary", username: "maryfindslove", photo: ""),
    Friend(name: "Tom", username: "tomiscool", photo: ""),
    Friend(name: "Andrew", username: "drew", photo: ""),
]

struct FriendsView: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                // Removed cause the header was too crowded
                //HeaderTab()
                    //.offset(y: 20)
                    //.frame(width: 380)
                Spacer()
                    .frame(height: 40)
                LoadFriendsListBox()
                    .offset(y: -20)
                LoadAddFriendsBox()
                    .offset(y: -15)
                FooterTab()
                    .offset(y: -15)
                    .frame(width: 300)
            }
        }
    }
}

struct LoadAddFriendsHeader : View {
    var body : some View {
        VStack{
            Text("Add Friend")
                .font(.custom(FontManager.NotoSans.regular, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .frame(width: 330, alignment: .leading)
            Text("Search by username")
                .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                .frame(width: 330, alignment: .leading)
        }
    }
}

struct LoadNoResultsText : View {
    var body : some View {
        VStack{
            Text("No results found")
                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
            Text("""
                Make sure that there are no typos in your
                search and the username is complete.
                """)
                .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
                .offset(y: 15)
        }
    }
}

struct AddFriend : View {
    @State private var searchText = ""
    var body : some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.bottom, 12)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            if (searchText.isEmpty){
                LoadNoResultsText()
                    .offset(y: -10)
            }
            ForEach(potentialFriends.filter ({ searchText.isEmpty ? false : $0.username == (searchText) }), id: \.username) { friend in
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 75, height: 75)
                    VStack{
                        Text(friend.name)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 15.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 300, alignment: .leading)
                        Text("@\(friend.username)")
                            .font(.custom(FontManager.NotoSans.regular, size: 11.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 300, alignment: .leading)
                        Button("Add"){
                            // add friend to list
                        }
                        .frame(width: 70, height: 28)
                        .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                        .foregroundColor(.white)
                        .background(Color("DarkGreen"))
                        .cornerRadius(10)
                        .offset(x: 20, y: -30)
                    }
                }
                .frame(width: 300, height: 55, alignment: .leading)
                .offset(y: 5)
            }
        }
    }
}

struct LoadAddFriendsBox : View {
    
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.white).opacity(0.7))
                .frame(width: 337, height: 220)
                .cornerRadius(10)
            VStack{
                LoadAddFriendsHeader()
                    .offset(x: 10, y: -5)
                AddFriend()
                    .offset(y: -10)
            }
        }
    }
}

struct ViewFriendsList: View {
    @State private var searchText = ""
    
    var body : some View {
        ScrollView{
            LazyVStack{
                SearchBar(text: $searchText)
                    .padding(.bottom, 12)
                                
                ForEach(friends.filter ({ searchText.isEmpty ? true : $0.name.contains(searchText) }), id: \.name) { friend in
                    HStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 75, height: 75)
                        VStack{
                            Text(friend.name)
                                .font(.custom(FontManager.NotoSans.semiBold, size: 15.0))
                                .foregroundColor(Color("DarkGreen"))
                                .frame(width: 300, alignment: .leading)
                            Text("@\(friend.username)")
                                .font(.custom(FontManager.NotoSans.regular, size: 11.0))
                                .foregroundColor(Color("DarkGreen"))
                                .frame(width: 300, alignment: .leading)
                            Button("Remove"){
                                // remove friend from list
                            }
                            .frame(width: 70, height: 28)
                            .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                            .foregroundColor(.white)
                            .background(Color("DarkGreen"))
                            .cornerRadius(10)
                            .offset(x: 20, y: -30)
                        }
                    }
                    .frame(width: 300, alignment: .leading)
                }
            }
        }
        .frame(width: 335, height: 400)
    }
}

struct LoadFriendsListBox : View {
    
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.white).opacity(0.7))
                .frame(width: 337, height: 420)
                .cornerRadius(10)
            VStack{
                if (friends.count == 0){
                    LoadNoFriendsText()
                        .background(LoginBackgroundLogo())
                }
                else{
                    ViewFriendsList()
                }
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
