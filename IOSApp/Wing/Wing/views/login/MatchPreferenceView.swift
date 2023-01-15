//
//  MatchPreferenceView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct MatchPreferenceView: View {
    
    @ObservedObject var viewModel: SignupViewModel = .method
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 120.0, height: 127.0)
                    .offset(y:-30)
                Spacer()
                    .frame(height: 50)
                Text("I prefer to see...")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                Picker(selection: $viewModel.preference, label: Text("Preference")) {
                    Text("Only men").tag(1)
                    Text("Only women").tag(2)
                    Text("Everyone").tag(3)
                }
                    .pickerStyle(WheelPickerStyle())
                    .offset(y: -30)
                Spacer()
                NavigationLink(destination: AgePreferenceView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background(Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
            }
        }
    }
}

struct MatchPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        MatchPreferenceView()
    }
}

