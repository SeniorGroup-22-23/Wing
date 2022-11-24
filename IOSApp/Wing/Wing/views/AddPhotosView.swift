//
//  AddPhotosView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-15.
//

import SwiftUI

struct AddPhotosView: View {
    @State private var numPhotos = 0
    @State private var arr = [0,0,2,4,6]
    @State private var showingImagePicker = false
    
    @State private var images = [Image?](repeating : nil, count : 8)
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            Color("White")
            
            VStack{
                VStack {
                    loadLogo()
                        .frame(width : 120.0, height : 127.0)
                    
                    HStack {
                        loadUploadPhotosText()
                    }
                    .padding(.top, -20)
                    
                    HStack {
                        loadMinimumPhotosText()
                            .frame(maxWidth: 300.0, alignment: .leading)
                    }
                        
                    HStack {
                        loadResetPhotosBtn()
                            .frame(maxWidth: 300.0, alignment: .leading)
                    }
                        .padding(.bottom, 10)
                }
                    .padding(.top, -30)
                    
                ScrollView {
                    VStack(spacing : 10) {
                        ForEach(1..<5) { i in
                            HStack(spacing : 10) {
                                ForEach(1..<3) { j in
                                    Group {
                                        let index = arr[i] + j
                                        if (index <= numPhotos) {
                                            getImage(num: index)
                                                .frame(width: 140, height: 175)
                                                .cornerRadius(10)
                                        } else if (index == numPhotos + 1) {
                                            ZStack {
                                                loadEmptyPhotoBox()
                                                loadPlusSignText()
                                            }
                                            .onTapGesture {
                                                showingImagePicker = true
                                            }
                                        } else {
                                            loadEmptyPhotoBox()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                    .onChange(of: inputImage) { _ in loadImage() }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
                    
                Spacer()
                    
                loadPhotoSuggesionText()
                    .multilineTextAlignment(.center)
                    
                NavigationLink(destination: HomePageView()) {
                    loadDoneText()
                        .frame(width: 231.0, height: 55.0)
                        .background(Color("MainGreen"))
                        .cornerRadius(20)
                }
            }
                .frame(width: 400.0)
        }
    }
    
    func loadLogo () -> Image {
        return Image("WhiteLogo")
                .resizable()
    }

    func loadUploadPhotosText () -> Text {
        return Text("Upload photos of you for your profile")
            .font(.custom(FontManager.KumbhSans.semiBold, size: 24.0))
    }
    
    func loadMinimumPhotosText () -> Text {
        return Text("\n* minimum of three photos")
                .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
                .foregroundColor(Color("BrightRed"))
    }

    func loadPhotoSuggesionText () -> Text {
        return Text("We suggest uploading clear photos of yourself for more matches.")
                .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
                .foregroundColor(Color("DisableGrey"))
    }
    
    func loadDoneText () -> Text {
        Text("Done")
            .foregroundColor(.white)
            .font(.custom("KumbhSans", size: 16.0))
    }
    
    func loadPlusSignText () -> Text{
        return Text("+")
                .foregroundColor(Color("DarkGrey"))
                .font(.custom(FontManager.NotoSans.bold, size: 100.0))
    }
    
    func loadEmptyPhotoBox () -> some View {
        return Rectangle()
                .fill(Color("DisableGrey"))
                .frame(width: 140, height: 175)
                .cornerRadius(10)
    }
    
    func loadResetPhotosBtn () -> some View {
        return Button("Reset Photos") {
            numPhotos = 0
        }
            .frame(width: 120.0, height: 30.0)
            .background(Color("DarkGrey"))
            .cornerRadius(20)
            .foregroundColor(.white)
            .font(.custom("KumbhSans", size: 16.0))
    }
    
    func getImage(num : Int) -> Image? {
        return images[num - 1]?
            .resizable()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        images[numPhotos] = Image(uiImage : inputImage)
        
        numPhotos += 1
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotosView()
    }
}
