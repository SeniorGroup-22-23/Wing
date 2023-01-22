//
//  PopUpView.swift
//  Wing
//
//  Created by Ankita Menon on 05/01/2023.
//

import SwiftUI


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
        ReportPopUpView(showingBlockAlert: showBlock())
    }
}
