//
//  HomePageView.swift
//  Wing
//
//  Created by Nury Kim on 2022-10-14.
//
import SwiftUI


let MainGreen = Color("MainGreen")
let DarkGreen = Color("DarkGreen")

struct HomePageView: View {
    @State private var showLogin = false
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                GreenLogo()
                    VStack{
                        WingText()
                        Button(action: {print("Button tapped")}) {
                            CreateAccountButton()
                            .cornerRadius(20.0)
                        }
                        Button(action: {print("Button tapped")}) {
                            LoginButton()
                            .cornerRadius(20.0)
                        }
                        TermsAndConditionsText()
                            .font(.custom("NotoSans",fixedSize:16))
                }.offset(y:130)
            }
        }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}



struct CreateAccountButton: View {
    var body: some View {
        Text("Create an account")
            .font(.custom("NotoSans",fixedSize:18))
            .foregroundColor(.white)
            .frame(width: 240, height: 55)
            .background(DarkGreen)
    }
}

struct LoginButton: View {
    var body: some View {
        Text("Log in")
            .font(.custom("NotoSans",fixedSize:18))
            .foregroundColor(.white)
            .frame(width: 240, height: 55)
            .background(DarkGreen)
    }
}

struct WingText: View {
    var body: some View {
        Text("WING")
            .font(.custom(FontManager.KumbhSans.bold, size: 64.0))
            .offset(y:20)
    }
}

struct GreenLogo: View {
    var body: some View {
        Image("GreenLogo")
            .resizable()
            .frame(width: 120.0, height: 120.0)
            .offset(y:-120)
    }
}


struct Text1: View {
    var body: some View {
        Text("By creating an account or logging in, you agree to our ")
        +
        Text("[Terms and Conditions](https://example.com)")
            .underline()
    }
}


struct TermsAndConditionsText: View {
    var body: some View {
        Text1()
            .multilineTextAlignment(.center)
            .frame(width:300, height:120)
            .offset(y:-20)
            .foregroundColor(.white)
            .accentColor(.white)
    }
}
