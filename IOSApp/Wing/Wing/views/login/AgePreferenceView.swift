//
//  AgePreferenceView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct AgePreferenceView: View {
    @State private var min = 0
    @State private var max = 0
    
    var body: some View {
        ZStack {
            Color("White")
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 120.0, height: 127.0)
                    .offset(y:-30)
                
                Text("My age preference is...")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                HStack{
                    Text("Min")
                        .font(.custom(FontManager.NotoSans.regular, size: 20.0))
                        .frame(width: 100)

                    Picker(selection: $min, label: Text("Min age")) {
                        ForEach(18 ..< 90) {  i in
                            Text("\(i)")
                        }
                        Text("90+")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 80)
                    .clipped()
                        
                }
                Text("to")
                    .font(.custom(FontManager.NotoSans.regular, size: 20.0))
                HStack{
                    Text("Max")
                        .font(.custom(FontManager.NotoSans.regular, size: 20.0))
                        .frame(width: 100)
                        .offset(y:-40)
                    Picker(selection: $max, label: Text("Max age")) {
                        ForEach(18 ..< 90) {  j in
                            Text("\(j)")
                        }
                        Text("90+")
                    }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 80)
                        .clipped()
                        .offset(y:-40)
                }
                Spacer()
                NavigationLink(destination: MaximumDistanceView()) {
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

struct AgePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        AgePreferenceView()
    }
}

