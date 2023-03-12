//
//  PromptView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-05.
//

import SwiftUI

struct PromptView: View {

    @ObservedObject var viewModel: SignupViewModel = .method
    
    var body: some View {
        ZStack {
            Color(.white)
            
            VStack {
                LoadWingImage()
                    .offset(y:-55)
                LoadPromptHeadline()
                
                Spacer()
                
                ForEach (1..<4) { i in
                    Group {
                        HStack {
                            displayPrompt(num : i)
                        }
                    }
                    
                    Menu {
                        showPicker(num : i)
                    }
                    label : {
                        loadPromptText(num : i)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                            .frame(width: 260.0, height: 40.0)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("DisableGrey"))
                            )
                    }
                    showTextField(num : i)
                }
                
                Spacer()

                NavigationLink(destination: MatchView().navigationBarBackButtonHidden(true)) {
                    loadDoneBtn()
                }
                .simultaneousGesture(TapGesture().onEnded{
                    Task{
                        try await viewModel.setUser()
                        try await viewModel.setProfile()
                        try await viewModel.setProfilePreview()
                        try await viewModel.setPromptResponse()
                        if(!viewModel.ans2.isEmpty){
                            try await viewModel.setPromptResponse(n: 2)
                        }
                        if(!viewModel.ans3.isEmpty){
                            try await viewModel.setPromptResponse(n: 3)
                        }
                    }
                })
                .disabled(viewModel.ans1.isEmpty)
                
            }
            .frame(width: 400.0)
            .onAppear {
                Task {
                    try await viewModel.getPrompts()
                }
            }
        }
    }
    
    func displayPrompt (num : Int) -> Text {
        if (num == 1) {
            return Text("* ")
                .font(.custom(FontManager.NotoSans.regular, size : 16.0))
                .foregroundColor(Color("BrightRed"))
            + Text("Prompt " + String(num))
                .font(.custom(FontManager.NotoSans.regular, size : 16.0))
        }
        
        return Text("Prompt " + String(num))
            .font(.custom(FontManager.NotoSans.regular, size : 16.0))
    }
    
    func showPicker (num : Int) -> some View{
        VStack {
            if (num == 1) {
                Picker("firstPrompt", selection: $viewModel.prompt1) {
                    displayPromptList()
                }
            } else if (num == 2) {
                Picker("secondPrompt", selection: $viewModel.prompt2) {
                    displayPromptList()
                }
            } else {
                Picker("thirdPrompt", selection: $viewModel.prompt3) {
                    displayPromptList()
                }
            }
        }
    }
    
    func displayPromptList () -> some View {
        ForEach (viewModel.promptList, id : \.id) { prompt in
            Text(prompt.promptText!).tag(prompt)
        }
    }
    
    func showTextField (num : Int) -> some View {
        VStack {
            if (num == 1) {
                TextField("", text: $viewModel.ans1)
                    .frame(width: 260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
            } else if (num == 2){
                TextField("", text: $viewModel.ans2)
                    .frame(width: 260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
            } else {
                TextField("", text: $viewModel.ans3)
                    .frame(width: 260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
    
    func loadDoneBtn () -> some View {
        Text("Done")
            .frame(width: 231.0, height: 55.0)
            .foregroundColor(.white)
            .background((viewModel.ans1.isEmpty) ? Color("DarkGrey") : Color("MainGreen"))
            .cornerRadius(20)
            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
    }
    
    func loadPromptText (num : Int) -> Text {
            if (num == 1) {
                return Text(viewModel.prompt1.promptText ?? "Click to choose a prompt.")
            } else if (num == 2) {
                return Text(viewModel.prompt2.promptText ?? "Click to choose a prompt.")
            } else {
                return Text(viewModel.prompt3.promptText ?? "Click to choose a prompt.")
            }
    }
}

struct LoadWingImage : View {
    var body : some View {
        Image("WhiteLogo")
            .resizable()
            .frame(width : 120.0, height : 127.0)
    }
}

struct LoadPromptHeadline : View {
    var body : some View {
        HStack {
            Text("Pick Your Prompts")
                .font(.custom(FontManager.KumbhSans.semiBold, size: 24.0))
                .frame(alignment: .leading)
        }
        
        HStack {
            Text("Choose prompts to show on your profile.")
                .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
                .frame(alignment: .leading)
        }
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}
