//
//  HelpView.swift
//  Wing
//
//  Created by Nury Kim on 2022-12-23.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack{
            LoadSmallLogo()
                .offset(y: 100)
            HelpPageText()
            StepsList()
                .frame(width: 370, height: 750)
                .offset(y: -50)
            Spacer()
        }
    }
}


struct HelpPageText: View {
    var body: some View {
        Text("Help Page")
            .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
    }
}

struct StepsList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            StepView(number: 1, title: "Set up your profile", description: "Add your photos and basic information to your profile.")
            StepView(number: 2, title: "Add Friends", description: "Add friends in the app by searching for their whole username.")
            StepView(number: 3, title: "Discover profiles", description: "Swipe up on profiles that you like, and swipe down on profiles that you dislike.")
            StepView(number: 4, title: "Match with profiles", description: "If both users swipe up on each other's profiles, then it's a match! You can start chatting with each other.")
            StepView(number: 5, title: "Wing profiles", description: "If you want to share a profile with a friend, double tap on the profile and select the option to send it to a friend.")
            StepView(number: 6, title: "Block profiles", description: "If you encounter a profile that you want to block or report, long press on the profile to bring up the option to do so.")
            StepView(number: 7, title: "Chat with matches", description: "Once you have matched with someone, you can start chatting with them by getting their contact information through the messaging feature within the app.")
        }
    }
}

struct StepView: View {
    let number: Int
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(number).")
                .font(.custom(FontManager.NotoSans.semiBold, size: 16.0))
                .foregroundColor(.blue)
                .padding(.top, 2)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.custom(FontManager.NotoSans.regular, size: 18.0))
                    .foregroundColor(.black)
                Text(description)
                    .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
