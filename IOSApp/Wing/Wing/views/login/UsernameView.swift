//
//  UsernameView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct UsernameView: View {

    @ObservedObject var viewModel: SignupViewModel = .method
   
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                LoadWingImage()
                    .offset(y:-55)
                Spacer()
                    .frame(height: 100)
                Text("Pick a Username")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                    .padding()
                Text("""
                     This will be public and will be used by your
                     friends to find you on the app.
                     """)
                    .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 30)
                TextField("", text: $viewModel.username)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .onChange(of: viewModel.username){ newValue in
                        Task {
                            try await viewModel.getUsernames(username: newValue)
                        }
                    }
                if viewModel.isTaken {
                    Text("username already taken")
                        .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                        .foregroundColor(.red)
                }
                else{
                    Spacer()
                        .frame(height: 30)
                }
                NavigationLink(destination: ProfileCompletionView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background((viewModel.username.count < 3 || viewModel.isTaken) ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .disabled(viewModel.username.count < 3 || viewModel.isTaken)
                Spacer()
            }
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}

