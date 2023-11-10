//
//  Specimen.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 10/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//







class Specimen{
    
    struct Fish: Codable, Identifiable{
        var id = 0
        var weight: Float = 0.0
        var length: Float = 0.0
    }
    
    var fish = Specimen.Fish()
    
    
        init(){
            var vect = Array<Double> ()
            
            for f in fishList {
                
                vect.append(f.getRarity())
                
            }
            
            self.fish.id = self.randomNumber(probabilities: vect)
            let species = fishList[fish.id]
            self.fish.weight = species.calculateWeight()
            self.fish.length = species.calculateLength()
            
            jsonService.updateAquarium(fish: fish)

            
        }
        
        func randomNumber(probabilities: [Double]) -> Int {

            // Sum of all probabilities (so that we don't have to require that the sum is 1.0):
            let sum = probabilities.reduce(0, +)
            print("SUM: \(sum)")
            // Random number in the range 0.0 <= rnd < sum :
            let rnd = Double.random(in: 0.0 ..< sum)
            // Find the first interval of accumulated probabilities into which rnd falls:
            var accum = 0.0
        //    print(probabilities.enumerated())
            for (i, p) in probabilities.enumerated() {
        //        print("i: \(i), p: \(p)")
                accum += p
        //        print("[Debug]: Accum \(accum)")
                if rnd < accum {
        //            print("[Debug]: I'm Here! (rnd < accum)")
                    return i
                }
            }
            // This point might be reached due to floating point inaccuracies:
        //    print("Nothing!")
            return (probabilities.count - 1)
        }
        
    
}
