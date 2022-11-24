//
//  CreateAccountView.swift
//  Wing
//
//  Created by Bryn Haines on 2022-10-29.
//

import SwiftUI
import Foundation

let darkGreyColor = Color("Black30")

struct CreateAccountView : View {

    var body: some View {
        ZStack{
            BackgroundLogo()
                .offset(y:-40)
            VStack {
                CreateAccountText()
                Button(action: {print("Button tapped")}) {
                    SignUpWithEmailText()
                    .cornerRadius(20.0)
                }
                .padding(.bottom, 17)
                Button(action: {print("Button tapped")}) {
                    SignUpWithPhoneText()
                    .cornerRadius(20.0)
                }
                SubTextMods()
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
        Text("[Log in](https://example.com)")
            .underline()
    }
}

struct SubTextMods: View {
    var body: some View {
        SubText()
            .font(.custom(FontManager.NotoSans.regular,fixedSize:16))
            .foregroundColor(.black)
            .accentColor(.black)
            .padding(.top, 20)
            .offset(y:13)
    }
}
