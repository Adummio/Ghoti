//
//  AquariumView.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 11/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI


struct DetailViewCatched: View {
    let fish : Specimen.Fish
    var body: some View {
        ScrollView{
        VStack {
            Image(fishList[fish.id].imageName)
                .resizable()
                .frame(minWidth: 40,maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .padding(10)
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color("SecondaryBlue"))
                VStack (spacing: 5) {
                    Spacer(minLength: 2)
                    if (fishList[fish.id].getRarity() == 0.3) {
                        HStack {
                            Image(systemName: "star.fill")
                            .font(.system(size: 12, design: .rounded))
                            Image(systemName: "star.fill")
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(Color("DarkGrey"))
                            Image(systemName: "star.fill")
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(Color("DarkGrey"))
                        }
                    } else if (fishList[fish.id].getRarity() == 0.6) {
                        HStack {
                            Image(systemName: "star.fill")
                            .font(.system(size: 12, design: .rounded))
                            Image(systemName: "star.fill")
                            .font(.system(size: 12, design: .rounded))
                            Image(systemName: "star.fill")
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(Color("DarkGrey"))
                        }
                    } else if (fishList[fish.id].getRarity() == 0.9) {
                    HStack {
                        Image(systemName: "star.fill")
                        .font(.system(size: 12, design: .rounded))
                        Image(systemName: "star.fill")
                        .font(.system(size: 12, design: .rounded))
                        Image(systemName: "star.fill")
                        .font(.system(size: 12, design: .rounded))
                    }
                    }
                    Text(fishList[fish.id].name)
                    .fontWeight(.bold)
                    .font(.system(size: 26, design: .rounded))
                    
                    
                Spacer(minLength: 1)
                    VStack(spacing:0) {
                        HStack {
                        Text("weight:")
                        .fontWeight(.semibold)
                            .font(.system(size: 15, design: .rounded))
                            Text("\(fish.weight)"+" "+"kg")
                        .fontWeight(.semibold)
                            .font(.system(size: 15, design: .rounded))
                        }
                    
                    HStack {
                        Text("length:")
                        .fontWeight(.semibold)
                            .font(.system(size: 15, design: .rounded))
                        Text("\(fish.length)"+" "+"m")
                        .fontWeight(.semibold)
                            .font(.system(size: 15, design: .rounded))
                    }
                        }
                    Text(fishList[fish.id].description)
                    .fontWeight(.regular)
                        .font(.system(size: 15, design: .rounded))
                    .padding(4)
                }.padding(10)
                
            }
            Button(action: {
                WKInterfaceController.reloadRootPageControllers(withNames: ["singleton"], contexts: nil, orientation: .vertical, pageIndex: 0)
            }) {
                Text("Collect")
            }
            
//            NavigationLink(destination: NewGame()) {
//                 Text("VAFFANCULO")
//            }
        }
        }.navigationBarBackButtonHidden(true)
    }
}




struct DetailViewCatched_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewCatched(fish: jsonService.json.aquarium[0])
    }
}
