//
//  StepCounterManager.swift
//  Gothi WatchKit Extension
//
//  Created by Yuri Spaziani on 21/01/2020.
//  Copyright © 2020 Watchdogs. All rights reserved.
//

import Foundation
import HealthKit
import Dispatch

class StepCounterManager: ObservableObject {
    
    private static let singleton = StepCounterManager()
    
    var myAnchor = HKQueryAnchor.init(fromValue: 0)
    
    private init(){}
    
    public static func getStepCounter() -> StepCounterManager
    {
        return self.singleton
    }
    
    private let healthStore = HKHealthStore()
    private let stepType =
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    
    @Published
    var i = 0
    
    func requestAccess(){
        if HKHealthStore.isHealthDataAvailable()
        {
            let dataType = Set(arrayLiteral: stepType)
            
            healthStore.requestAuthorization(toShare: dataType, read: dataType)
            { [weak self] (success, error) in
                
                guard let strongSelf = self else { return }
                
                if success {
                    debugPrint("Access to HealthKit data has been granted")
                    strongSelf.readHealthKitData()
                } else {
                    debugPrint("Error requesting HealthKit authorization: \(error)")
                }
                
            }
            
        }else{
            debugPrint("Can't request access to HealthKit when it's not supported on the device.")
            return
        }
        
        
    }
    
    
    func requestAccessWithCompletion(completion: @escaping(_ success: Bool, _ error: NSError?) -> Void) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            debugPrint("Can't request access to HealthKit when it's not supported on the device.")
            return
        }
        
        healthStore.requestAuthorization(toShare: Set(arrayLiteral: stepType), read: Set(arrayLiteral: stepType))
        { [weak self] (success, error) in
            
            guard let strongSelf = self else { return }
            
            if success {
                debugPrint("Access to HealthKit data has been granted")
                strongSelf.readHealthKitData()
                
                strongSelf.setUpBackgroundDeliveryForDataTypes(types: Set(arrayLiteral: self!.stepType))
            } else {
                debugPrint("Error requesting HealthKit authorization: \(error)")
            }
            DispatchQueue.main.async() {
                completion(success, error as NSError?)
            }
            
        }
    }
    
    
    
    
    private func setUpBackgroundDeliveryForDataTypes(types: Set<HKObjectType>) {
        for type in types {
            guard let sampleType = type as? HKSampleType else { print("ERROR: \(type) is not an HKSampleType"); continue }
            let query = HKObserverQuery(sampleType: sampleType, predicate: nil) { [weak self] (query, completionHandler, error) in
                debugPrint("observer query update handler called for type \(type), error: \(error)")
                guard let strongSelf = self else { return }
                strongSelf.queryForUpdates(type: type)
                completionHandler()
            }
            healthStore.execute(query)
            
//            healthStore.enableBackgroundDeliveryForType(type, frequency: .immediate) { (success, error) in
//                debugPrint("enableBackgroundDeliveryForType handler called for \(type) - success: \(success), error: \(error)")
//            }
        }
    }
    
    private func queryForUpdates(type: HKObjectType) {
//        debugPrint("Dio gay")
    }
    
    
    func readHealthKitData() {
//        i += 1
//        debugPrint("Passi \(i)")
        
    }
    
    
    func startObserving(){
        
        
        
        let query = HKObserverQuery(sampleType: stepType, predicate: nil) {
            query, completionHandler, error in
            
            if error != nil {
                
                // Perform error handling.
                print("*** An error occured while setting up the stepCount observer. \(error!.localizedDescription) ***")
                abort()
            }
        }
        healthStore.execute(query)
        
    }
    
    
    func startStepsQuery() {
        
        
        self.requestAccess()
        
        // Create the query.
        let query = HKAnchoredObjectQuery(type: stepType,
                                          predicate: nil,
                                          anchor: myAnchor,
                                          limit: HKObjectQueryNoLimit)
        { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            guard let samples = samplesOrNil, let deletedObjects = deletedObjectsOrNil else {
                // Handle the error.
                fatalError("*** An error occurred during the initial query: \(errorOrNil!.localizedDescription) ***")
            }
            
            self.myAnchor = newAnchor!
            let data : Data = NSKeyedArchiver.archivedData(withRootObject: newAnchor as Any)
            
            for stepCountSample in samples {
                // Process the new step count samples.
                print("Diooo")
            }
            
            for deletedStepCountSamples in deletedObjects {
                // Process the deleted step count samples.
            }
        }

        // Optionally, add an update handler.
        query.updateHandler = { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            guard let samples = samplesOrNil, let deletedObjects = deletedObjectsOrNil else {
                // Handle the error.
                fatalError("*** An error occurred during an update: \(errorOrNil!.localizedDescription) ***")
            }
            
            self.myAnchor = newAnchor!
            let data : Data = NSKeyedArchiver.archivedData(withRootObject: newAnchor as Any)
            
            for stepCountSample in samples {
                self.i += 1
                print("Steps: \(self.i)")
            }
            
            for deletedStepCountSamples in deletedObjects {
                // Process the deleted step count samples from the update.
            }
        }

        // Run the query.
        healthStore.execute(query)
    }
    
    
    
}
