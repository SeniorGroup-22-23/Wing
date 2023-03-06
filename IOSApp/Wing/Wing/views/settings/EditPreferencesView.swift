//
//  EditPreferencesView.swift
//  Wing
//
//  Created by Nury Kim on 2022-12-23.
//
import CoreLocation
import CoreLocationUI
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    func requestLocation() {
        manager.requestLocation()
        print("Requesting location")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
                
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Error handling
        print(error)
        //Error Domain=kCLErrorDomain Code=1 "(null)" asks user to give access to location
    }
}

struct EditPreferencesView: View {
    @State private var selected = 1
    var body: some View {
        ZStack {
            Color("White")
            
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 120.0, height: 127.0)
                    .offset(y:-30)
                Spacer()
                
                Text("I prefer to see...")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                Picker(selection: $selected, label: Text("Preference")) {
                        Text("Only men").tag(1)
                        Text("Only women").tag(2)
                        Text("Everyone").tag(3)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .offset(y: -30)
                
                Spacer()
                NavigationLink(destination: EditAgeRangeView()) {
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

struct EditAgeRangeView: View {
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
                NavigationLink(destination: EditMaxDistanceView()) {
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

struct EditMaxDistanceView: View {
    @StateObject var locationManager = LocationManager()
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
                        .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
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
                    if let location = locationManager.location {
                        Text("Your location: \(location.latitude), \(location.longitude)")
                    }

                    LocationButton {
                        locationManager.requestLocation()
                    }
                    .frame(height: 44)
                    .padding()
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: SettingsHomeView()) {
                        Text("Done")
                            .frame(width: 231.0, height: 55.0)
                            .foregroundColor(.white)
                            .background((locationManager.location?.latitude == nil) ? Color("DarkGrey") : Color("MainGreen"))
                            .cornerRadius(70)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    }
                    .disabled(locationManager.location?.latitude == nil)
                }
            }
        }
}

struct EditPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        EditPreferencesView()
    }
}
