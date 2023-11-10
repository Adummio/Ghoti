//
//  JsonService.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 10/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import Foundation

//bream 30 to 55 cm


let fishList: [Fish] =
[Fish("Bream", 0.5, 2.0, 0.5, 2.0, "This is an amazing fish! Is a species of freshwater and marine fish.", Type.sweet, 0.3, "bream", Size.small, false),
 Fish("Dragon Fish", 0.5, 2.0, 0.5, 2.0, "This is an amazing fish that you can find in amazing waters.", Type.salty, 0.6, "dragonFish", Size.medium, false),
 Fish("Tuna", 0.5, 2.0, 0.5, 2.0, "This is an amazing saltwater fish. Tuna, like opah and mackerel sharks are the only species of fish that can maintain a body temperature higher than that of the surrounding water.", Type.sweet, 0.6, "tuna", Size.small, false),
 Fish("Carp", 0.5, 2.0, 0.5, 2.0, " Carp are various species of oily freshwater fish.", Type.sweet, 0.9, "carp", Size.small, false),
 Fish("Boot", 0.5, 2.0, 0.5, 2.0, "This is an amazing trash that you can find in amazing waters if you don't stop to polluting!.", Type.sweet, 0.3, "boot", Size.small, false)]



class JsonService {
    
    
    struct JsonData: Codable
    {
        var aquarium: [Specimen.Fish] =
            [Specimen.Fish(id: 0, weight: 0.5, length: 0.5),
            Specimen.Fish(id: 1, weight: 0.5, length: 0.5),
            Specimen.Fish(id: 2, weight: 0.5, length: 0.5),
            Specimen.Fish(id: 3, weight: 0.5, length: 0.5),
            Specimen.Fish(id: 4, weight: 0.5, length: 0.5)]
        var isCatched: [Bool] = []
        var isFishing: Bool = false
        var isNotFishing: Bool = true
    }
    
    func beginFishing(){
        json.isNotFishing = false
        json.isFishing = true
        
        writeJson()
    }
    
    func stepsReached(){
        json.isNotFishing = false
        json.isFishing = false
        
        writeJson()
    }
    
    func endFishing(){
        json.isNotFishing = true
        json.isFishing = false
        
        writeJson()
    }
    
    func updateAquarium(fish: Specimen.Fish)
    {
        for j in 0...(json.aquarium.count - 1) {
            if(json.aquarium[j].id == fish.id && json.aquarium[j].weight < fish.weight)
            {
                json.aquarium[j] = fish
                writeJson()
                print("salvato json \(json.aquarium[j])")
                return
            }
        }
        
        return
        
    }
    
    func fishingHasBegun() -> Bool
    {
        return json.isFishing
    }
    
    func fishingHasEnded() -> Bool
    {
        return json.isNotFishing
    }
    
    static let singleton = JsonService()
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let jsonFilePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("configuration.json")
    var json = JsonData()
    
    private init() {
        checkJsonExists()
        readJson()
    }
    
    static func getJsonService() -> JsonService {
        return .singleton
    }
    
    

    
    func readJson() {
        do
        {
            let data = try Data(contentsOf: jsonFilePath, options: .mappedIfSafe)
            let decoder: JSONDecoder = JSONDecoder.init()
            json = try decoder.decode(JsonData.self, from: data)
        }catch{
            checkJsonExists()
        }
    }
    
    private func checkJsonExists(){
        if !fileManager.fileExists(atPath: jsonFilePath.path, isDirectory: &isDirectory)
        {
            fileManager.createFile(atPath: jsonFilePath.path, contents: nil, attributes: nil)
        }
    }
    
    private func writeJson() {
        var data: Data?
        let encoder = JSONEncoder()
        
        do{
            data = try encoder.encode(json)
        }catch{
            print("Couldn't encode json file.")
        }
        
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath)
            try? file.truncate(atOffset: 0)
            file.write(data!)
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
}
