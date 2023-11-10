//
//  ContentView.swift
//  Fishing Project WatchKit Extension
//
//  Created by Fabbio on 08/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI
import WatchKit
import CoreMotion
import AVFoundation
import HealthKit
import UserNotifications

var player: AVAudioPlayer?

//var x : Double = 0.0
//var y : Double = 0.0
//var z : Double = 0.0

let motionManager = CMMotionManager()
var fishingText = "Catch a fish after 200 steps."

let stepCounterManager = StepCounterManager.getStepCounter()





func dropSound() {
    if let path = Bundle.main.path(forResource: "waterdrop", ofType: "wav") {
        let fileUrl = URL(fileURLWithPath: path)
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: fileUrl)
            guard let player = player else { return }
            player.play()
        }
        catch{
            print("Sound Error")
        }
    }
}



struct PDGame: View {
    
    @ViewBuilder
    var body: some View{
        if(jsonService.fishingHasEnded()){
//            StartFishingView()
        }else{
            ProgressView()
        }
    }
}

struct ProgressView: View{
    var body: some View{

        Text("ossì che bello pescare")
        
    }
}


struct NewGame: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject
    var stepManager = stepCounter
    
    
    var body: some View {
        
        VStack {
            Text("\(fishingText)")
                .fontWeight(.semibold)
                .font(.system(size: 18)).multilineTextAlignment(.center)
            
            NavigationLink(destination: WaterView(viewModel: WaterViewModel())) {
                            Text("Start Fishing")
            }
            
//            Button(action:
//                {
                    //stepCounter.startStepsQuery()
//                    jsonService.beginFishing()
//                    self.presentationMode.wrappedValue.dismiss()
                    
//                })
 ///            NavigationLink(destination: CatchView()) {
//                Text("Start Fishing")
//            }
//            .disabled(jsonService.fishingHasBegun())
//                    Text("X: \(x)")
//                    Text("Y: \(y)")
//                    Text("Z: \(y)")
        }
//        .onAppear(perform: {
////            stepCounterManager.requestAccess()
//            stepCounterManager.startStepsQuery()
//            if(!jsonService.fishingHasEnded())
//            {
//                fishingText = "Steps: \(self.stepManager.i)"
//            }
//        })
        
    }
}


func notifyUser(_ message : [String : Any]) { // TEST 
    
    let content = UNMutableNotificationContent()
    content.title = "You got one."
    content.body = "Come and see your catch!"
    content.userInfo = message
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = "myCategory"
    let time = 2
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
    let request = UNNotificationRequest(identifier: "Test", content: content, trigger: trigger)

    let center = UNUserNotificationCenter.current()

    center.removeAllPendingNotificationRequests()
    center.removeAllDeliveredNotifications()

    center.add(request)
}

struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        NewGame()
    }
}
