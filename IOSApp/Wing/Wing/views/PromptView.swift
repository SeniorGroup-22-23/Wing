//
//  PromptView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-05.
//

import SwiftUI

struct PromptView: View {
    @State private var prompt1 = ""
    @State private var prompt2 = ""
    @State private var prompt3 = ""
    @State private var ans1: String = ""
    @State private var ans2: String = ""
    @State private var ans3: String = ""
    
    // FOR EMMA : you will have to load the actual prompts into this promptList variable
    @State private var promptList = ["What's your favourite color?", "How many siblings do you have?"]
    
    var body: some View {
        ZStack {
            Color("White")
            
            VStack {
                LoadWingImage()
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
                    } label : {
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
                
                NavigationLink(destination: HomePageView()) {
                    loadDoneBtn()
                }
                .disabled(ans1.isEmpty)
            }
                .frame(width: 400.0)
        }
    }
    
    func displayPrompt (num : Int) -> Text {
        // if it's the first prompt, add the star so user knows it's required
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
        // NOTE for Emma:
        // This is where you'd load the prompts
        
        VStack {
            if (num == 1) {
                // load the prompt selection in the prompt1 variable
                Picker("firstPrompt", selection: $prompt1) {
                    displayPromptList()
                }
            } else if (num == 2) {
                // load the prompt selection in the prompt2 variable
                Picker("secondPrompt", selection: $prompt2) {
                    displayPromptList()
                }
            } else {
                // load the prompt selection in the prompt3 variable
                Picker("thirdPrompt", selection: $prompt3) {
                    displayPromptList()
                }
            }
        }
    }
    
    func displayPromptList () -> some View {
        ForEach (promptList, id : \.self) { prompt in
            Text(prompt)
        }
    }
    
    func showTextField (num : Int) -> some View {
        VStack {
            if (num == 1) {
                TextField("", text: $ans1)
                    .frame(width: 260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
            } else if (num == 2){
                TextField("", text: $ans2)
                    .frame(width: 260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
            } else {
                TextField("", text: $ans3)
                    .frame(width: 260.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
            }
        }
    }
    
    func loadDoneBtn () -> some View {
        Text("Done")
            .frame(width: 231.0, height: 55.0)
            .foregroundColor(.white)
            .background((ans1.isEmpty) ? Color("DarkGrey") : Color("MainGreen"))
            .cornerRadius(20)
            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
    }
    
    func loadPromptText (num : Int) -> Text {
        if ((num == 1 && prompt1 == "") || (num == 2 && prompt2 == "") || (num == 3 && prompt3 == "")) {
            return Text("Click to choose a prompt.")
        }
        
        if (num == 1) {
            return Text(prompt1)
        } else if (num == 2) {
            return Text(prompt2)
        } else {
            return Text(prompt3)
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
