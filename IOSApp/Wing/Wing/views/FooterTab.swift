//
//  FooterTab.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-29.
//
import SwiftUI

struct FooterTab : View {
    var body : some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                HStack {
                    LoadWingBtn()
                    Spacer()
                    LoadMatchBtn()
                    Spacer()
                    LoadMessageBtn()
                }
            }
        }
    }
}

struct LoadWingBtn : View {
    // TODO : change navigation destination once settings view is created
    var body : some View {
        NavigationLink(destination : HomePageView()) {
            Image("WingTab")
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .offset(x : 20)
        }
    }
}

struct LoadMatchBtn : View {
    // TODO : change navigation destination once settings view is created
    var body : some View {
        NavigationLink(destination : HomePageView()) {
            Image("MatchTab")
                .resizable()
                .frame(width: 40.0, height: 40.0)
        }
    }
}

struct LoadMessageBtn : View {
    // TODO : change navigation destination once settings view is created
    var body : some View {
        NavigationLink(destination : HomePageView()) {
            Image("MessageTab")
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .offset(x : -20)
        }
    }
}

struct FooterTab_Previews: PreviewProvider {
    static var previews: some View {
        FooterTab()
    }
}
