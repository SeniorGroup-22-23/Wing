//
//  MaximumDistanceView.swift
//  Wing
//
//  Created by Ankita Menon on 23/10/2022.
//

import SwiftUI

struct MaximumDistanceView: View {
    @State private var distSelected = 1
    let results = [1, 5, 10, 20, 30, 40, 50, 100, 150, 200, 250]
    
    var body: some View {
        ZStack {
            Color("White")
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 120.0, height: 127.0)
                    .offset(y:-30)
                Spacer()
                    .frame(height: 50)
                Text("My maximum distance...(km)")
                    .font(.custom(FontManager.NotoSans.regular, size: 24.0))
                    .offset(y:50)
                Picker(selection: $distSelected, label: Text("Distance")) {
                    ForEach(results, id: \.self) {  i in
                        Text("\(i)")
                    }
                }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 200)
                    .offset(y:20)
                Spacer()
                NavigationLink(destination: OccupationView()) {
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

struct MaximumDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        MaximumDistanceView()
    }
}

