//
//  MaximumDistanceView.swift
//  Wing
//
//  Created by Ankita Menon on 23/10/2022.
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

struct MaximumDistanceView: View {
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
                NavigationLink(destination: OccupationView()) {
                    Text("Next")
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

struct MaximumDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        MaximumDistanceView()
    }
}

