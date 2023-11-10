//
//  AquariumView.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 11/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI

var collected = 5

struct AquariumView: View {
    
    
    var body: some View {
        VStack(spacing: 25){
            VStack{
                Text("Aquarium")
                    .fontWeight(.semibold)
                    .font(.system(size: 22, design: .rounded))
                    .foregroundColor(Color("MainBlue"))
                Text("\(collected) of \(jsonService.json.aquarium.count) collected")
                    .fontWeight(.regular)
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(Color.gray)
               List(jsonService.json.aquarium) { fish in
                NavigationLink(destination: DetailView(fish:fish)) {
                    HStack {
                        // 2.
                        Text("\(fishList[fish.id].name)")
                            
                        .font(.system(size: 22, design: .rounded))
                            .fontWeight(.regular)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .padding(.vertical, 30)
                    }.font(.title)
                }
                }
            }
            }
        
    }
}


struct AquariumView_Previews: PreviewProvider {
    static var previews: some View {
        AquariumView()
    }
}
