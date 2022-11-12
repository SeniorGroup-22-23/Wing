//
//  MotherView.swift
//  Wing
//
//  Created by Bryn Haines on 2022-10-28.
//

import SwiftUI
import Foundation

struct MotherView: View{
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View{
        switch viewRouter.currentPage{
        case .page1:
            HomePageView(viewRouter: ViewRouter())
        case .page2:
            LoginView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
