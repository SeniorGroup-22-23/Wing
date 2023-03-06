//
//  ProfilesGridView.swift
//  Wing
//
//  Created by Ankita Menon on 10/12/2022.
//

import SwiftUI

struct ProfilesGridView: View {
    let verticalSpacing: CGFloat = 15
    let itemHeight: CGFloat = 200
    let itemWidth: CGFloat = 150
    let horizontalSpacing: CGFloat = 20
    let column = GridItem(.fixed(150))
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                TabView {
                    ForEach((1...getNumPages(size: reader.size)), id: \.self) {page in
                        VStack {
                            LazyVGrid(columns: getColumns(size: reader.size), spacing: verticalSpacing) {
                                ForEach(getItems(size: reader.size, page: page), id: \.name) { profile in
                                    ZStack{
                                        Rectangle()
                                            .fill(Color("DarkGreen").opacity(0.8))
                                            .frame(width: 150, height: 200)
                                            .cornerRadius(10)
                                        VStack{
                                            Rectangle()
                                                .fill(Color(.white).opacity(0.8))
                                                .frame(width: 130, height: 140)
                                                .cornerRadius(10)
                                                .offset(y: 10)
                                            Text("\(profile.name), \(String(profile.age))")
                                                .font(.custom(FontManager.NotoSans.semiBold, size: 18.0))
                                                .foregroundColor(Color(.white))
                                                .frame(width: 130, alignment: .leading)
                                                .offset(y: 3)
                                            HStack{
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 20, height: 20)
                                                    .offset(y: -10)
                                                Text("Sent by \(profile.wingSent)")
                                                    .font(.custom(FontManager.NotoSans.regular, size: 10.0))
                                                    .foregroundColor(Color(.white))
                                                    .frame(width: 110, alignment: .leading)
                                                    .offset(y: -12)
                                            }
                                        }
                                    }
                                }
                                
                            }
                            .padding()
                        }
                        .id(UUID())
                        .tabItem{
                            
                        }.tag(page)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 540)
            }
        }
    }
    
    func imagesPerColumn(height: CGFloat) -> Int {
        var retval = Int( (height - verticalSpacing) / (itemHeight + verticalSpacing))
        retval -= 1 // Let's remove 1, keep it roomy below.
        return retval
    }
    func columnsPerPage(width: CGFloat) -> Int {
        return Int( width / (itemWidth + horizontalSpacing))
    }
                
    func getPageSize(size: CGSize) -> Int {
        return imagesPerColumn(height: size.height) * columnsPerPage(width: size.width)
    }
    
    func getNumPages(size: CGSize) -> Int {
        var retval = wingprofiles.count / getPageSize(size: size) + 1
        if wingprofiles.count % getPageSize(size: size) == 0 {
            retval = retval - 1
        }
        return retval
    }
    
    func getColumns(size: CGSize) -> [GridItem] {
        return [GridItem](repeating: column, count: columnsPerPage(width: size.width))
    }
    
    func getItems(size: CGSize, page: Int) -> [WingedProfiles] {
        let pageSize = getPageSize(size: size)
        let startIdx = (page-1) * pageSize
        let endIdx = min(startIdx + pageSize-1, wingprofiles.count-1)
        var array : [WingedProfiles] = []
        array = Array(wingprofiles[startIdx...endIdx])
        return array
    }
}

struct ProfilesGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesGridView()
    }
}
