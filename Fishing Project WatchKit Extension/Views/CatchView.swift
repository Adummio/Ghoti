//
//  AquariumView.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 11/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI



struct CatchView: View {
    @State private var pulsate = false
    @State private var textAnim = false
    @State private var showRecord = false
    
    func getOpacity() {
        for j in 0...(jsonService.json.aquarium.count - 1){
            if self.catchedFish.fish.weight > jsonService.json.aquarium[j].weight{
                self.showRecord = true
                break
            }
        }
    }
    
    var catchedFish = Specimen() // we'll pass the name of the one you catch
    var body: some View {
        
        VStack {
                
//            if catchedFish.fish.length > xx || catchedFish.fish.weight > xx
            Text("New Record!")
                           .fontWeight(.semibold)
                           .font(.system(size: 16, design: .rounded))
                           .foregroundColor(Color("MainBlue"))
                .opacity(showRecord ? 1 : 0)
            NavigationLink(destination: DetailViewCatched(fish: catchedFish.fish)) { // destination will be the tab with fish datas
                Spacer(minLength: 15)
                ZStack{
                    
                Image("bg")
                    .resizable()
                    .frame(minWidth: 40,maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                        .padding(10)

                    .scaleEffect(pulsate ? 0.6 : 0.8)
                    .opacity(pulsate ? 1 : 0.9)
                    .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulsate)
//                    .onAppear() {
//                        self.pulsate.toggle()
//                    }
                
                    Image(fishList[catchedFish.fish.id].imageName)
                    .resizable()
                    .frame(minWidth: 40,maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                        .padding(10)

                }
                Spacer(minLength: -10)
            }.buttonStyle(PlainButtonStyle())
            VStack(spacing: 0){
                Text("Gotcha!")
                .fontWeight(.bold)
                .font(.system(size: 26, design: .rounded))
                .foregroundColor(Color.white)
                    .scaleEffect(textAnim ? 0.8 : 1)
                    .opacity(textAnim ? 0.9 : 1)
                .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: textAnim)
                .onAppear() {
                    self.textAnim.toggle()
                }
               
                Text("\(fishList[catchedFish.fish.id].name)")
                .fontWeight(.regular)
                .font(.system(size: 16, design: .rounded))
                    .foregroundColor(Color.gray)
            }
        } .onAppear(perform: {
            self.getOpacity()
            dropSound()
            WKInterfaceDevice.current().play(.click)
        })
        
        .navigationBarHidden(true)
    }
}



struct CatchView_Previews: PreviewProvider {
    static var previews: some View {
        CatchView()
    }
}
