//
//  BioView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-03.
//

import SwiftUI
import Combine

class BioMethod: ObservableObject {
    private init(){
        
    }
    static let method = BioMethod()
    @Published var bio_method = ""
}

struct BioView: View {
    
    @ObservedObject var bio_method: BioMethod = .method
    @ObservedObject var viewModel: SignupViewModel = .method
    
    let textLimit = 150

    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                LoadWingImage()
                    .offset(y:-55)
                Spacer()
                    .frame(height: 100)
                Text("Tell us about yourself... write a short bio")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                    .frame(width: 320)
                TextEditor(text: $viewModel.bio)
                    .frame(width:218.0, height: 144.0)
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("DisableGrey")))
                    .onReceive(Just(viewModel.bio)) { _ in limitText(textLimit) }
                Text("150 character limit")
                    .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    .padding(.leading, 90)
                Spacer()
                NavigationLink(destination: PromptView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background(Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .simultaneousGesture(TapGesture().onEnded{
                    self.bio_method.bio_method = viewModel.bio
                    
                })
                .offset(y: -15)
            }
        }
    }
    
    func limitText(_ upper: Int) {
            if viewModel.bio.count > upper {
                viewModel.bio = String(viewModel.bio.prefix(upper))
            }
    }
}

struct BioView_Previews: PreviewProvider {
    static var previews: some View {
        BioView()
    }
}
