//
//  PopUpView.swift
//  Wing
//
//  Created by Ankita Menon on 05/01/2023.
//

import SwiftUI

//TODO: Remove previously defined struct

class Friend: ObservableObject, Equatable {
    let name: String
    let username: String
    let photo: String
    
    init(name: String, username: String, photo: String) {
        self.name = name
        self.username = username
        self.photo = photo
    }
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name == rhs.name && lhs.username == rhs.username && lhs.photo == rhs.photo
    }
}

//TODO: Replace this list with real friends after endpoint implementation
let friends: [Friend] = [
    Friend(name: "Mike", username: "mikewing", photo: ""),
    Friend(name: "Colin", username: "colinfindslove", photo: ""),
    Friend(name: "Kathy", username: "kathyiscool", photo: ""),
    Friend(name: "Jake", username: "jakeyyy", photo: ""),
    Friend(name: "Hannah", username: "hannahforever", photo: "")
]

class SelectedFriend: ObservableObject {
    @Published var selected: Friend?
    
    func select(friend: Friend) {
        self.selected = friend
    }
    func reset() {
        self.selected = nil
    }
}

struct LoadFriendsProfilesForPopup : View {
    @EnvironmentObject var selectedFriend: SelectedFriend

    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
                ForEach(friends, id:\.name) { friend in
                    VStack{
                        Circle()
                            .fill(.white)
                            .frame(width: 45, height: 45)
                            .overlay(
                                Circle()
                                    .stroke(self.selectedFriend.selected == friend ? Color.red : Color.clear, lineWidth: 2)
                            )
                            .onTapGesture {
                                self.selectedFriend.select(friend: friend)
                            }
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


struct LoadFriendsBoxForPopup : View {
    @EnvironmentObject var selectedFriend: SelectedFriend
    
    var body : some View {
        ZStack{
            VStack{
                if ((friends.count) == 0){
                    LoadNoFriendsText()
                }
                else{
                    LoadFriendsProfilesForPopup()
                        .environmentObject(selectedFriend)
                }
            }
        }
    }
}

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}

struct ModalPopUpView: View {
    
    @ObservedObject var showingBlockAlert: showBlock
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Block or Report")
                .font(.custom(FontManager.NotoSans.semiBold, size : 24.0))
                .padding(20)
            Button(action: {
                showingBlockAlert.blockAlert = true
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Block")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 80)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
            Spacer()
                .frame(width: 300, height: 25)
            Button(action: {
                showingBlockAlert.bothAlert = true
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Block and Report")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 37)
            .padding(.vertical, 12)
            .background(Color("BrightRed").opacity(0.7))
            .cornerRadius(10)
            Divider()
                .frame(width: 300, height: 2)
                .overlay(Color("DarkGrey"))
                .offset(y: 15)
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                showingBlockAlert.blockAlert = false
                showingBlockAlert.bothAlert = false
                
            }) {
                Text("Cancel")
            }.foregroundColor(.black).padding(20)
                
            
        }.background(.white.opacity(0.8)).clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
    }
}

struct WingPopUpView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @StateObject var selectedFriend = SelectedFriend()
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Wing")
                .font(.custom(FontManager.NotoSans.semiBold, size : 30.0))
                .padding(10)
            Text("Send this profile to a friend")
                .font(.custom(FontManager.NotoSans.semiBold, size : 18.0))
                .foregroundColor(Color("DarkGrey"))
            
            LoadFriendsBoxForPopup()
                .environmentObject(selectedFriend)
            
            Divider()
                .frame(width: 310, height: 2)
                .overlay(Color("DarkGrey"))
                .offset(y: 15)
            HStack{
                Button(action: {
                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                    self.selectedFriend.reset()
                    
                }) {
                    Text("Cancel")
                }.foregroundColor(.black)
                    .padding(.horizontal, 45)
                    .padding(.vertical, 15)
                
                Divider()
                    .frame(width: 2, height: 45)
                    .overlay(Color("DarkGrey"))
                    .offset(y: 5)
                
                Button(action: {
                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                    //Write code to send friend the profile
                    
                }) {
                    Text("Send")
                }.foregroundColor(.black)
                    .padding(.horizontal, 55)
                    .padding(.vertical, 15)
                    
            }
                
        }
        .background(.white.opacity(0.8)).clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
    }
}

struct Buttons : View {
    @ObservedObject var showingBlockAlert: showBlock
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body : some View {
        VStack{
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Fake profile")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 80)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Innappropriate profile details")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Harassment or bullying")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 35)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Unwanted sexual messages")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Scam")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 105)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("Underaged person")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 55)
            .padding(.vertical, 12)
            .background(Color("MainGreen"))
            .cornerRadius(10)
        }
    }
}

struct ReportPopUpView: View {
    
    @ObservedObject var showingBlockAlert: showBlock
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Report and Block")
                .font(.custom(FontManager.NotoSans.semiBold, size : 24.0))
                .padding(15)
            Text("Select the reason that best fits you")
            Buttons(showingBlockAlert: showingBlockAlert)
            Spacer()
                .frame(width: 300, height: 10)
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                showingBlockAlert.blockAlert = false
                showingBlockAlert.bothAlert = false
            }) {
                Text("Cancel")
            }.foregroundColor(.black).padding(20)
            
        }.background(.white.opacity(0.8)).clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        //ModalPopUpView(showingBlockAlert: showBlock())
        //ReportPopUpView(showingBlockAlert: showBlock())
        WingPopUpView()
            .environmentObject(SelectedFriend())
    }
}
