//
//  FriendsView.swift
//  Wing
//
//  Created by Ankita Menon on 30/11/2022.
//
import SwiftUI

struct Friend{
    let name: String
    let username: String
    let photo: String
}

//TODO: Replace this list with real friends after endpoint implementation
let friends: [Friend] = [
    Friend(name: "Mike", username: "mikewing", photo: ""),
    Friend(name: "Colin", username: "colinfindslove", photo: ""),
    Friend(name: "Kathy", username: "kathyiscool", photo: ""),
    Friend(name: "Jake", username: "jakeyyy", photo: ""),
    Friend(name: "Hannah", username: "hannahforever", photo: "")
]

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
                    .offset(y: -32)
                LoadRequestsBox()
                    .offset(y: -27)
                LoadAddFriendsBox()
                    .offset(y: -20)
                FooterTab()
                   // .offset(y: -5)
                    .frame(width: 300)
            }
        }
    }
}

struct LoadRequestsBox : View {
    @ObservedObject var wingViewModel: WingViewModel = .method
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.white).opacity(0.7))
                .frame(width: 337, height: 165)
                .cornerRadius(10)
            VStack{
                if ((wingViewModel.friendRequests.count) == 0){
                    LoadRequestsHeader()
                        .offset(y: -28)
                    LoadNoRequestsText()
                        .offset(y: -13)
                }
                else{
                    LoadRequestsHeader()
                        .offset(y: 10)
                    LoadRequestProfiles()
                        .offset(x: 53, y: -5)
                }
            }
        }
    }
}

struct LoadRequestsHeader : View {
    var body : some View {
        VStack{
            Text("Requests")
                .font(.custom(FontManager.NotoSans.regular, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .frame(width: 330, alignment: .leading)
                .offset(x:6)
        }
    }
}

struct LoadNoRequestsText : View {
    var body : some View {
        VStack{
            Text("No requests yet")
                .font(.custom(FontManager.NotoSans.semiBold, size: 20.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
            Text("""
                When you recieve a friend request, it will appear here
                """)
                .font(.custom(FontManager.NotoSans.regular, size: 14.0))
                .foregroundColor(Color("DarkGreen"))
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .offset(y: 15)
        }
    }
}

struct LoadRequestProfiles : View {
    @ObservedObject var wingViewModel: WingViewModel = .method
    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
               ForEach(wingViewModel.friendRequestPreviews) { friend in
                    VStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                        Text(friend.name!)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 10.0))
                            .foregroundColor(Color("DarkGreen"))
                        Text("@\(friend.username!)")
                            .font(.custom(FontManager.NotoSans.regular, size: 10.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 90)
                        Button(action: {
                            Task{
                                try await wingViewModel.getFriendRequests()
                                try await wingViewModel.acceptFriend(friendID: friend.userId!)
                            }
                        }, label: {
                            Text("Accept")
                        })
                            .font(.custom(FontManager.NotoSans.bold, size: 10.0))
                            .foregroundColor(Color(.white))
                            .frame(width: 48, height: 17)
                            .background(Color("DarkGreen"))
                            .cornerRadius(10)
                    }
                }
            }
        }
        //.frame(width: 320)
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
                .offset(y: 5)
        }
    }
}

struct AddFriend : View {
    
    @ObservedObject var wingViewModel: WingViewModel = .method
    
    @State private var searchText = ""
    var body : some View {
        VStack{
            SearchBar(text: $searchText)
                .padding(.bottom, 12)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .onChange(of: searchText){ newValue in
                    Task {
                        try await wingViewModel.searchUser(username: newValue)
                    }
                }
            if(searchText.isEmpty){
                VStack{
                    Spacer()
                        .frame(height: 60)
                        .offset(y:-30)
                }
            }
            if (!searchText.isEmpty && wingViewModel.searchedUser.username == nil){
                LoadNoResultsText()
                    .offset(y: -10)
            }
            if(wingViewModel.searchedUser.username != nil){
                HStack{
                    Circle()
                        .fill(.white)
                        .frame(width: 75, height: 75)
                    VStack{
                        Text(wingViewModel.searchedUser.name!)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 15.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 300, alignment: .leading)
                        Text("@\(wingViewModel.searchedUser.username!)")
                            .font(.custom(FontManager.NotoSans.regular, size: 11.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 300, alignment: .leading)
                        Button(action: {
                            Task{
                                try await wingViewModel.addFriend(friendID: wingViewModel.searchedUser.userId!)
                            }
                        }, label: {
                            Text("Add")
                        })
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
    
    @ObservedObject var wingViewModel: WingViewModel = .method
    @ObservedObject var signupViewModel: SignupViewModel = .method
    
    @State private var searchText = ""
    
    var body : some View {
            LazyVStack{
                SearchBar(text: $searchText)
                    .padding(.bottom, 12)
                    .offset(y: 5)
                ScrollView{
                ForEach(wingViewModel.friendProfilePreviews.filter ({ searchText.isEmpty ? true : $0.name!.contains(searchText) })) { friend in
                    HStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 75, height: 75)
                        VStack{
                            Text(friend.name!)
                                .font(.custom(FontManager.NotoSans.semiBold, size: 15.0))
                                .foregroundColor(Color("DarkGreen"))
                                .frame(width: 300, alignment: .leading)
                            Text("@\(friend.username!)")
                                .font(.custom(FontManager.NotoSans.regular, size: 11.0))
                                .foregroundColor(Color("DarkGreen"))
                                .frame(width: 300, alignment: .leading)
                            Button(action: {
                                Task{
                                    try await wingViewModel.getConfirmedFriendRequests()
                                    try await wingViewModel.deleteFriendship(friendID: friend.userId!)
                                    try await wingViewModel.getFriendIDs()
                                    for prospect in wingViewModel.friendIDs{
                                        try await wingViewModel.getFriendProfilePreviews(friendID: prospect)
                                    }
                                    
                                }
                            }, label: {
                                Text("Remove")
                            })
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
            .offset(y: 5)
            .frame(width: 335, height: 165)
            .onAppear {
                Task {
                    if let unwrappedID = signupViewModel.user.id {
                        wingViewModel.userID = unwrappedID
                    }
                    try await wingViewModel.getFriendRequests()
                    for requesterID in wingViewModel.friendRequests{
                        try await wingViewModel.getFriendRequestProfiles(requesterID: requesterID.requesterId!)
                    }
                }
            }
        }
    }
}

struct LoadFriendsListBox : View {
    
    var body : some View {
        ZStack{
            Rectangle()
                .fill(Color(.white).opacity(0.7))
                .frame(width: 337, height: 245)
                .cornerRadius(10)
            VStack{
                if (friends.count == 0){
                    LoadNoFriendsText()
                        .background(BackgroundLogo())
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
