//
//  HeaderTab.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-29.
//

import SwiftUI

struct HeaderTab: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                HStack {
                    LoadSmlLogo()
                    Spacer()
                    LoadSettingsBtn()
                }
                
                
            }
        }
    }
}

struct LoadSmlLogo : View {
    var body : some View {
        Image("GreenLogo")
            .resizable()
            .frame(width: 75.0, height: 75.0)
            .offset(x : 10, y:-30)
    }
}

struct LoadSettingsBtn : View {
    var body : some View {
        // TODO : change navigation destination once settings view is created
        NavigationLink(destination : HomePageView()) {
            Image("SettingsBtn")
                .resizable()
                .frame(width: 30.0, height: 30.0)
                .offset(x : -20, y : -30)
        }
    }
}

struct HeaderTab_Previews: PreviewProvider {
    static var previews: some View {
        HeaderTab()
    }
}
