//
//  OccupationView.swift
//  Wing
//
//  Created by Ankita Menon on 23/10/2022.
//

import SwiftUI

struct OccupationView: View {
    
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
                    .frame(height: 150)
                Text("What's your occupation?")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                Spacer()
                    .frame(height: 35)
                TextField("", text: $viewModel.occupation)
                    .frame(width:260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                NavigationLink(destination: AddPhotosView()) {
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

struct OccupationView_Previews: PreviewProvider {
    static var previews: some View {
        OccupationView()
    }
}

