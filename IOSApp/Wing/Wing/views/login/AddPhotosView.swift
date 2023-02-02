//
//  AddPhotosView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-15.
//

import SwiftUI

class PhotoMethod: ObservableObject {
    private init(){
        
    }
    static let method = PhotoMethod()
    @Published var photo_method = [Image?](repeating : nil, count : 8)
}

struct AddPhotosView: View {
    @State private var numPhotos = 0
    @State private var arr = [0,0,2,4,6]
    @State private var showingImagePicker = false
    
    @State private var images = [Image?](repeating : nil, count : 8)

    @State private var inputImage: UIImage?
    @ObservedObject var photo_method: PhotoMethod = .method
    @ObservedObject var viewModel: SignupViewModel = .method
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack{
                VStack {
                    LoadLogo()
                    
                    HStack {
                        LoadUploadPhotosText()
                    }
                    
                    HStack {
                        LoadMinimumPhotosText()
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
                                                LoadEmptyPhotoBox()
                                                LoadPlusSignText()
                                            }
                                            .onTapGesture {
                                                showingImagePicker = true
                                            }
                                        } else {
                                            LoadEmptyPhotoBox()
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
                    
                LoadPhotoSuggesionText()
                    
                NavigationLink(destination: BioView()) {
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                        .frame(width: 231.0, height: 55.0)
                        .background((numPhotos < 3) ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(20)
                }
                .disabled(numPhotos < 3)
                .simultaneousGesture(TapGesture().onEnded{
                    self.photo_method.photo_method = images
                    
                })
            }
                .frame(width: 400.0)
        }
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
        viewModel.imagesData[numPhotos] = inputImage.jpegData(compressionQuality: 0.0)
    
        numPhotos += 1
    }
}

struct LoadLogo : View {
    var body : some View {
        Image("WhiteLogo")
            .resizable()
            .frame(width : 120.0, height : 127.0)
    }
}

struct LoadUploadPhotosText : View {
    var body : some View {
        Text("Upload photos of you for your profile")
            .font(.custom(FontManager.KumbhSans.semiBold, size: 24.0))
            .padding(.top, -20)
    }
}

struct LoadMinimumPhotosText : View {
    var body : some View {
        Text("\n* minimum of three photos")
            .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
            .foregroundColor(Color("BrightRed"))
            .frame(maxWidth: 300.0, alignment: .leading)
    }
}

struct LoadPhotoSuggesionText : View {
    var body : some View {
        Text("We suggest uploading clear photos of yourself for more matches.")
            .font(.custom(FontManager.KumbhSans.regular, size: 16.0))
            .foregroundColor(Color("DisableGrey"))
            .multilineTextAlignment(.center)
    }
}

struct LoadPlusSignText : View {
    var body : some View {
        Text("+")
            .foregroundColor(Color("DarkGrey"))
            .font(.custom(FontManager.NotoSans.bold, size: 100.0))
    }
}

struct LoadEmptyPhotoBox : View {
    var body : some View {
        Rectangle()
            .fill(Color("DisableGrey"))
            .frame(width: 140, height: 175)
            .cornerRadius(10)
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotosView()
    }
}
