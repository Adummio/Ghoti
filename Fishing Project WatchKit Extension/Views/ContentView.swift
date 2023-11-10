//
//  ContentView.swift
//  Fishing Project WatchKit Extension
//
//  Created by Fabbio on 08/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI
import WatchKit
import UserNotifications


// CROWN  https://developer.apple.com/documentation/watchkit/wkcrowndelegate/1650886-crowndidrotate


// VIBRATION  https://developer.apple.com/documentation/watchkit/wkinterfacedevice/1628128-play



let serviceLocator = ServiceLocator.getServiceLocator()


struct ContentView: View {
    var body: some View {
        VStack(spacing:10) {
            Spacer()
            NavigationLink(destination: WaterView(viewModel: WaterViewModel())) {

                Text("Go Fishin'")
                .fontWeight(.bold)
                    .font(.system(size: 28, design: .rounded))
                    .padding(.vertical, 20)
                    .padding(.horizontal,10)
            }
                .frame(minWidth: 100, maxWidth: .infinity)
            .background(Color("MainBlue"))
            .foregroundColor(.white)
            .cornerRadius(20)
            .buttonStyle(PlainButtonStyle())
            NavigationLink(destination: AquariumView()) {
                Text("Aquarium")
                    
                .fontWeight(.bold)
                .font(.system(size: 26, design: .rounded))
                .padding(.vertical, 10)
                .padding(.horizontal,10)
                }
                .frame(minWidth: 100, maxWidth: .infinity)
                .background(Color("SecondaryBlue"))
                .foregroundColor(.white)
                .cornerRadius(20)
                .buttonStyle(PlainButtonStyle())
        }.navigationBarTitle(Text("Ghoti"))
    
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        YourCollection()
    }
}
