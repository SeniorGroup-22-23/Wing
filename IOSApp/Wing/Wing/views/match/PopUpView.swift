//
//  PopUpView.swift
//  Wing
//
//  Created by Ankita Menon on 05/01/2023.
//

import SwiftUI

//TODO: can be replaced when merged into main finally
struct PopUpNoFriendsText : View {
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

class SelectedPreview: ObservableObject {
    @Published var selected: ProfilePreview?
    
    func select(preview: ProfilePreview) {
        self.selected = preview
    }
    func reset() {
        self.selected = nil
    }
}

struct LoadFriendsProfilesForPopup : View {
    
    @ObservedObject var wingPopupViewModel: WingPopupViewModel = .method
    @EnvironmentObject var selectedPreview: SelectedPreview

    var body : some View {
        ScrollView(.horizontal){
           LazyHStack{
               ForEach(wingPopupViewModel.friendProfilePreviews, id:\.userId) { preview in
                    VStack{
                        let photoData = preview.primaryPhoto!
                        let photoUI = UIImage(data: photoData)!
                        let mainPhoto = Image(uiImage: photoUI)
                        
                        mainPhoto
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                            .overlay(
                                Circle()
                                    .stroke(self.selectedPreview.selected?.userId == preview.userId ? Color.red : Color.clear, lineWidth: 2)
                            )
                            .onTapGesture {
                                self.selectedPreview.select(preview: preview)
                            }
                        Text(preview.name!)
                            .font(.custom(FontManager.NotoSans.semiBold, size: 10.0))
                            .foregroundColor(Color("DarkGreen"))
                        Text("@\(preview.username!)")
                            .font(.custom(FontManager.NotoSans.regular, size: 10.0))
                            .foregroundColor(Color("DarkGreen"))
                            .frame(width: 90)
                    }
                }
            }
        }
        .frame(width: 300, height: 90)
        .onAppear{
            Task {
                try await wingPopupViewModel.getFriends() 
                try await wingPopupViewModel.getProfilePreviews()
            }
        }
    }
}


struct LoadFriendsBoxForPopup : View {
    @EnvironmentObject var selectedPreview: SelectedPreview
    @ObservedObject var wingPopupViewModel: WingPopupViewModel = .method
    
    var body : some View {
        ZStack{
            VStack{
                if (wingPopupViewModel.noFriends){
                    //TODO: bug. when friend is added during sim (no frinds to 1 friend) it still does not load (works the other way when friend is removed)
                    PopUpNoFriendsText()
                }
                else {
                    LoadFriendsProfilesForPopup()
                        .environmentObject(selectedPreview)
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

struct MatchPopUpView: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    var body: some View {
        VStack(alignment: .center) {
            Text("It's a MATCH!")
                .font(.custom(FontManager.NotoSans.semiBold, size : 24.0))
                .padding(.top)
            
            Text("Check the Messages tab\nto browse your matches.")
                .font(.custom(FontManager.NotoSans.regular, size : 16.0))
                .padding(10)
            
            Divider()
                .frame(width: 300, height: 2)
                .overlay(Color("DarkGrey"))
                .offset(y: 15)
            Button(action: {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }) {
                Text("OK")
            }.foregroundColor(.black).padding(20)
        }.background(.white.opacity(0.8)).clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 3)
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
    @StateObject var selectedPreview = SelectedPreview()
    
    @ObservedObject var wingPopupViewModel: WingPopupViewModel = .method
    @ObservedObject var matchViewModel: MatchViewModel = .method
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Wing")
                .font(.custom(FontManager.NotoSans.semiBold, size : 30.0))
                .padding(10)
            Text("Send this profile to a friend")
                .font(.custom(FontManager.NotoSans.semiBold, size : 18.0))
            
            LoadFriendsBoxForPopup()
                .environmentObject(selectedPreview)
            
            Divider()
                .frame(width: 310, height: 2)
                .overlay(Color("DarkGrey"))
                .offset(y: 15)
            HStack{
                Button(action: {
                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                    self.selectedPreview.reset()
                    
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
                    Task {
                        if(selectedPreview.selected != nil){
                            try await wingPopupViewModel.wingUser(prospectId: matchViewModel.prospectProfile.userId!, recipientId: selectedPreview.selected!.userId!)
                        }
                    }
                    
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
    @ObservedObject var viewModel: BlockReportViewModel = .method
    @ObservedObject var showingBlockAlert: showBlock
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    var body : some View {
        VStack{
            Button(action: {
                showingBlockAlert.reportAlert = true
                showingBlockAlert.bothAlert = false
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                viewModel.issue = 1
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
                viewModel.issue = 2
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
                viewModel.issue = 3
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
                viewModel.issue = 4
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
                viewModel.issue = 5
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
                viewModel.issue = 6
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
            .environmentObject(SelectedPreview())
    }
}
