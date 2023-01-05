//
//  ContentView.swift
//  Login
//
//  Created by Bryn Haines on 2022-10-15.
//
import SwiftUI
import Foundation
import UIKit

let MainGreen = Color("MainGreen")

struct LoginView : View {
    
    @ObservedObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            WhiteLogo()
            LoginText()
            EmailorPhoneText()
            TextField("", text: $viewModel.credential)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("DisableGrey"), lineWidth: 2)
                )
                .background(.white)
                .padding(.bottom, 5)
                .frame(width: 300)
            PasswordText()
            SecureField("", text: $viewModel.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color("DisableGrey"), lineWidth: 2)
                )
                .background(.white)
                .padding(.bottom, 40)
                .frame(width: 300)
                ForgotPasswordText()
                Button(action: {
                    Task{
                        await viewModel.getUserbyPhone()
                    }
                }) {
                        ButtonContent()
                }
        }
        .background(
        BackgroundLogo())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginText: View {
    var body: some View {
        Text("Log in")
            .font(.custom(FontManager.KumbhSans.semiBold,fixedSize:30))
            .padding(.bottom, 20)
            .offset(y:-10)
    }
}

struct WhiteLogo: View {
    var body: some View {
        Image("WhiteLogo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .offset( y: -130)
    }
}

struct ButtonContent: View {
    var body: some View {
        Text("Sign in")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:18))
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(MainGreen)
            .cornerRadius(15.0)
            .offset(y:-10)
    }
}

struct ForgotPasswordText: View {
    var body: some View {
        Text("[Forgot Password?](https://example.com)")
            .underline()
            .font(.custom(FontManager.NotoSans.regular,fixedSize:15))
            .accentColor(Color.black)
            .padding(.bottom, 20)
            .offset(y: -20)
            
            
    }
}

struct BackgroundLogo: View {
    var body: some View {
        Image("WhiteLogo")
            .resizable()
            .padding(.trailing)
            .frame(width: 650, height: 675)
            .offset(y:35)
            .opacity(0.1)
    }
}

struct EmailorPhoneText: View {
    var body: some View {
        Text("Email or phone number")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:17))
            .padding(.trailing, 100)
            .offset(y:8)
    }
}

struct PasswordText: View {
    var body: some View {
        Text("Password")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:17))
            .padding(.trailing, 215)
            .offset(y:8)
    }
}
