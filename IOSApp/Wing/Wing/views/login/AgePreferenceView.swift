//
//  AgePreferenceView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct AgePreferenceView: View {
    
    @ObservedObject var viewModel: SignupViewModel = .method
    
    var body: some View {
        ZStack {
            Color(.white)
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

                    Picker(selection: $viewModel.minAge, label: Text("Min age")) {
                        ForEach(Int16(18) ..< Int16(90), id: \.self) {  i in
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
                    Picker(selection: $viewModel.maxAge, label: Text("Max age")) {
                        ForEach(Int16(18) ..< Int16(90), id: \.self) {  j in
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

