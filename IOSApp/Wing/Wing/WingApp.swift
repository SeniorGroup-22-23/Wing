//
//  WingApp.swift
//  Wing
//
//  Created by Allie Griffin on 2022-10-03.
//

import SwiftUI

@main
struct WingApp: App{
    
    @StateObject var viewRouter = ViewRouter()
    
        var body: some Scene {
            WindowGroup {
                MotherView(viewRouter: viewRouter)
            }
        }
    
}


//@main
//struct WingApp: App {
//    var body: some Scene {
//        WindowGroup {
//            HomePageView()
//        }
//    }
//}
