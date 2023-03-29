
//
//  ProfilesGridView.swift
//  Wing
//
//  Created by Ankita Menon on 10/12/2022.
//
import SwiftUI


struct ProfilesGridView: View {
    
    @ObservedObject var wingViewModel: WingViewModel = .method
    @ObservedObject var signupViewModel: SignupViewModel = .method
    
    let verticalSpacing: CGFloat = 15
    let itemHeight: CGFloat = 200
    let itemWidth: CGFloat = 150
    let horizontalSpacing: CGFloat = 20
    let column = GridItem(.fixed(150))
    
    let numbers = 0...3
    
    var body: some View {
        
        VStack {
            GeometryReader { reader in
                TabView {
                    ForEach((1...getNumPages(size: reader.size)), id: \.self) {page in
                        VStack {
                            LazyVGrid(columns: getColumns(size: reader.size), spacing: verticalSpacing) {
                                ForEach(getItems(size: reader.size, page: page), id:\.id) { profile in
                                    ZStack{
                                        Rectangle()
                                            .fill(Color("DarkGreen").opacity(0.8))
                                            .frame(width: 150, height: 200)
                                            .cornerRadius(10)
                                        VStack{
                                            let photoData = profile.firstPhoto.photo!
                                            let photoUI = UIImage(data: photoData)!
                                            let mainPhoto = Image(uiImage: photoUI)
                                            
                                            mainPhoto
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(Rectangle())
                                                .frame(width: 130, height: 140)
                                                .cornerRadius(10)
                                                .offset(y: 10)
                                            
                                            Text("\(profile.profile.name!), \(profile.profile.birthdate!.age)")
                                                .font(.custom(FontManager.NotoSans.semiBold, size: 18.0))
                                                .foregroundColor(Color(.white))
                                                .frame(width: 130, alignment: .leading)
                                                .offset(y: 3)
                                            HStack{
                                                let photoData = profile.senderPhoto.photo!
                                                let photoUI = UIImage(data: photoData)!
                                                let mainPhoto = Image(uiImage: photoUI)
                                                
                                                mainPhoto
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
                                                    .frame(width: 20, height: 20)
                                                    .offset(y: -10)
                                                
                                         
                                                Text("Sent by \(profile.sender.name!)")
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
    
    func getItems(size: CGSize, page: Int) -> [wing] {
        var startIdx: Int = Int()
        var endIdx: Int = Int()
        if(page.self == 1){
            startIdx = 0
            endIdx = 3
        }
        else if(page.self == 2){
            startIdx = 4
            endIdx = 6
        }
       // let pageSize = getPageSize(size: size)
       // let startIdx = page.self-1
        //let endIdx = min(startIdx + pageSize-1, wingViewModel.wingedProfiles.count-1)
        var array : [wing] = []
        if(startIdx >= 0 && endIdx <= (wings.count-1) && startIdx <= endIdx){
            array = Array(wings[startIdx...endIdx])
        }
        print(array)
        return array
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
        var retval = wingViewModel.wingedList.count / getPageSize(size: size) + 1
        if wingViewModel.wingedList.count % getPageSize(size: size) == 0 {
            retval = retval - 1
        }
        return retval
    }
    
    func getColumns(size: CGSize) -> [GridItem] {
        return [GridItem](repeating: column, count: columnsPerPage(width: size.width))
    }
    
}

struct ProfilesGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesGridView()
    }
}
