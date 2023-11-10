//
//  Fish.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 10/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI

public struct Fish : Identifiable{
    public var id = UUID()
    var name: String!
    var minWeight: Float!
    private var maxWeight: Float!
    private var minLength: Float!
    private var maxLength: Float!
    var description: String!
    private var type: Type!
    var rarity: Double!
    var imageName: String!
    var size: Size!
    var isCatched: Bool!
    
    init(_ name: String, _ minW: Float, _ maxW: Float, _ minL: Float, _ maxL: Float, _ description: String, _ type: Type, _ rarity: Double, _ imageName: String, _ size: Size, _ isCatched: Bool){
        self.name = name
        self.minWeight = minW
        self.maxWeight = maxW
        self.minLength = minL
        self.maxLength = maxL
        self.description = description
        self.type = type
        self.rarity = rarity
        self.imageName = imageName
        self.size = size
        self.isCatched = isCatched
    }
    
    init(_ fish: Fish) {
        
        self.name = fish.name
        self.minWeight = fish.getMinWeight()
        self.maxWeight = fish.getMaxWeight()
        self.minLength = fish.getMinLength()
        self.maxLength = fish.getMaxLength()
        self.description = fish.description
        self.type = fish.type
        self.rarity = fish.rarity
        self.imageName = fish.imageName
        self.size = fish.size
        self.isCatched = fish.isCatched
    }
    
    func calculateWeight() -> Float {
        
        let float = Float.random(in: self.minWeight ... self.maxWeight)
        let rounded = (float * 100).rounded() / 100
               
        return(rounded)
        
        
    }
    
    func calculateLength() -> Float {
        
        let float = Float.random(in: self.minLength ... self.maxLength)
        let rounded = (float * 100).rounded() / 100
        
        return(rounded)
        
    }
    
    func getMinWeight() -> Float {
        
        return self.minWeight
        
    }
    
    func getMaxWeight() -> Float {
        
        return self.maxWeight
        
    }
    
    func getMinLength() -> Float {
        
        return self.minLength
        
    }
    
    func getMaxLength() -> Float {
        
        return self.maxLength
        
    }
    
    func getRarity() -> Double {
        
        return self.rarity
        
    }
}
