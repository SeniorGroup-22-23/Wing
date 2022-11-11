//
//  PromptView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-05.
//

import SwiftUI

struct PromptView: View {
    @State private var prompt1 = 1
    @State private var prompt2 = 1
    @State private var prompt3 = 1
    @State private var ans1: String = ""
    @State private var ans2: String = ""
    @State private var ans3: String = ""
    
    var body: some View {
        ZStack {
            Color("White")
            
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width : 120.0, height : 127.0)
                
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
                        Text("What's your favourite food?")
                            .frame(width: 260.0, height: 40.0)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                            .foregroundColor(.black)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("DisableGrey"))
                            )
                    }
                    
                    showTextField(num : i)
                }
                
                Spacer()
                
                NavigationLink(destination: HomePageView()) {
                    Text("Done")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background(Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom("KumbhSans", size: 16.0))
                }
            }
                .frame(width: 400.0)
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
                Picker("", selection: $prompt1) {
                    Text("Item 1").tag(1)
                    Text("Item 2").tag(2)
                }
            } else if (num == 2) {
                Picker("", selection: $prompt2) {
                    Text("Item 1").tag(1)
                    Text("Item 2").tag(2)
                }
            } else {
                Picker("", selection: $prompt3) {
                    Text("Item 1").tag(1)
                    Text("Item 2").tag(2)
                }
            }
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
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}
