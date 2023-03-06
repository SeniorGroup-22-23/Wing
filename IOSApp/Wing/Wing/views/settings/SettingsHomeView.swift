//
//  SettingsHomeView.swift
//  Wing
//
//  Created by Nury Kim on 2022-12-23.
//

import SwiftUI

struct SettingsHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("MainGreen")
                    .ignoresSafeArea()
                VStack {
                    HeaderTab()
                        .padding(.bottom, 100)
                    
                    ShowSettingsText()
                    
                    ShowOptions()
                    
                    FooterTab()
                        .padding(.top, 120)
                }
                .background(
                    SettingsBackgroundLogo())
            }
        }
        .navigationBarHidden(true)
    }
}

struct ShowSettingsText: View {
    var body : some View {
        Text("Settings")
            .font(.custom(FontManager.KumbhSans.semiBold, size: 32.0))
            .foregroundColor(.white)
    }
}

struct SettingsBackgroundLogo: View {
    var body : some View {
        Image("GreenLogo")
            .resizable()
            .padding(.trailing)
            .frame(width: 650, height: 675)
            .offset(y:35)
            .opacity(0.1)
    }
}

struct ShowOptions: View {
    var body : some View {
        NavigationLink(destination: EditProfileView()) {
            createButton(txt: "Edit Profile")
        }
        NavigationLink(destination: EditPreferencesView()) {
            createButton(txt: "Edit Preferences")
        }
        NavigationLink(destination: EditAccountView()) {
            createButton(txt: "Edit Account")
        }
        NavigationLink(destination: HelpView()) {
            createButton(txt: "Help")
        }
        NavigationLink(destination: HomePageView()) {
            createButton(txt: "Log Out")
        }
    }
    
    func createButton(txt: String) -> some View {
        return Text(txt)
            .frame(width: 231.0, height: 55.0)
            .foregroundColor(.white)
            .background(Color("DarkGreen"))
            .cornerRadius(20)
            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
    }
}

struct SettingsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHomeView()
    }
}
