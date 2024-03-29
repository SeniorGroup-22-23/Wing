//
//  HomePageView.swift
//  Wing
//
//  Created by Nury Kim on 2022-10-14.
//
import SwiftUI
import Foundation

let MediumGreen = Color("MediumGreen")

struct HomePageView: View {
    
    @ObservedObject var viewModel: SignupViewModel = .method
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("MainGreen")
                    .ignoresSafeArea()
                    VStack{
                        GreenLogo()
                        WingFontImage()
                        NavigationLink(destination: CreateAccountView()){
                            CreateAccountButton()
                                .cornerRadius(20.0)
                        }.offset(y:62)
                        NavigationLink(destination: LoginView()){
                            LoginButton()
                                .cornerRadius(20.0)
                        }.offset(y:65)
                            .simultaneousGesture(TapGesture().onEnded{
                                viewModel.username = ""
                                viewModel.password = ""
                            })
                    }
            }
        }
        .navigationBarHidden(true)
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct WingFontImage: View{
    var body: some View {
        Image("WingFont")
            .resizable()
            .frame(width: 250, height: 260)
            .offset(y:130)
    }
}


struct CreateAccountButton: View {
    var body: some View {
        Text("Create an account")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:18))
            .foregroundColor(.white)
            .frame(width: 240, height: 55)
            .background(MediumGreen)
    }
}

struct LoginButton: View {
    var body: some View {
        Text("Log in")
            .font(.custom(FontManager.NotoSans.regular,fixedSize:18))
            .foregroundColor(.white)
            .frame(width: 240, height: 55)
            .background(MediumGreen)
    }
}


struct GreenLogo: View {
    var body: some View {
        Image("GreenLogo")
            .resizable()
            .frame(width: 120.0, height: 120.0)
            .offset(y:-60)
    }
}


