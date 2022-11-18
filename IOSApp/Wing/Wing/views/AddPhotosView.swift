//
//  AddPhotosView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-15.
//

import SwiftUI

struct PromptView: View {
    @State private var prompt1 = 1
    @State private var prompt2 = 1
    @State private var prompt3 = 1
    @State private var ans1: String = ""
    @State private var ans2: String = ""
    @State private var ans3: String = ""
    
    @State private var numPhotos = 0
    
    var body: some View {
        ZStack {
            Color("White")
            
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width : 120.0, height : 127.0)
                
                HStack {
                    Text("Upload photos of you for your profile")
                        .font(.custom(FontManager.KumbhSans.semiBold, size: 24.0))
                        .frame(alignment: .leading)
                }
                
                HStack {
                    Text("\n* minimum of three photos")
                        .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
                        .foregroundColor(Color("BrightRed"))
                        .frame(maxWidth: 300.0, alignment: .leading)
                }
                
                Spacer()
                
                var counter = 0
                
                ScrollView {
                    VStack {
                        ForEach(0..<4) {_ in
                            HStack(spacing: 10) {
                                ForEach(0..<2) { i in
                                    displayBlankPhoto(num: counter)
                                    counter = counter + 1
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                Text("We suggest uploading clear photos of yourself for more matches.")
                    .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
                    .foregroundColor(Color("DisableGrey"))
                    .frame(alignment: .center)
                
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
    
    func displayBlankPhoto (num : Int) -> Text {
        if (num == numPhotos) {
            return Text("+")
                .foregroundColor(.white)
                .frame(width: 160, height: 200)
                .background(Color("DisableGrey")) as! Text
        }
        
        return Text("")
            .foregroundColor(.white)
            .frame(width: 160, height: 200)
            .background(Color("DisableGrey")) as! Text
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView()
    }
}
