//
//  CreateAccountView.swift
//  Wing
//
//  Created by Bryn Haines on 2022-10-29.
//

import SwiftUI
import Foundation

let darkGreyColor = Color("Black30")

class ChosenMethod: ObservableObject {
    private init(){
        
    }
    static let method = ChosenMethod()
    @Published var email_method = false
    @Published var phone_method = false
}

struct CreateAccountView : View {

    @ObservedObject var chosen_method: ChosenMethod = .method
    @ObservedObject var viewModel: SignupViewModel = .method
    
    var body: some View {
            ZStack{
                BackgroundLogo()
                    .offset(y:-40)
                VStack {
                    CreateAccountText()
                    NavigationLink(destination: EmailAddressView()){
                        SignUpWithEmailText()
                            .cornerRadius(20.0)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        self.chosen_method.email_method = true
                        self.chosen_method.phone_method = false
                        
                    })
                    .padding(.bottom, 17)
                    NavigationLink(destination: PhoneNumberView()){
                        SignUpWithPhoneText()
                            .cornerRadius(20.0)
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        self.chosen_method.phone_method = true
                        self.chosen_method.email_method = false
                        
                    })
                    SubTextMods()
                }
            }
            .onAppear{
                Task{
                    viewModel.setMethod()
                }
            }
    }
}

struct CreateAccountView_Preview: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

struct SignUpWithEmailText: View {
    var body: some View {
        Text("Sign up with Email")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:18))
            .foregroundColor(.white)
            .frame(width: 231, height: 55)
            .background(darkGreyColor)
    }
}

struct SignUpWithPhoneText: View {
    var body: some View {
        Text("Sign up with phone number")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:18))
            .foregroundColor(.white)
            .frame(width: 231, height: 55)
            .background(darkGreyColor)
    }
}

struct CreateAccountText: View {
    var body: some View {
        Text("Create an Account")
            .font(.custom(FontManager.KumbhSans.semiBold,fixedSize:30))
            .padding(.bottom, 20)
            .offset(y: -10)
    }
}

struct SubText: View {
    var body: some View {
        Text("Already have an account ? ")
        +
        Text("Log in")
            .underline()
    }
}

struct SubTextMods: View {
    var body: some View {
        NavigationLink(destination: LoginView()){
            SubText()
                .font(.custom(FontManager.NotoSans.regular,fixedSize:16))
                .foregroundColor(.black)
                .accentColor(.black)
                .padding(.top, 20)
                .offset(y:13)
        }
    }
}
