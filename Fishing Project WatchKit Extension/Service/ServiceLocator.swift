//
//  ServiceLocator.swift
//  Fishing Project WatchKit Extension
//
//  Created by Yuri Spaziani on 10/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

class ServiceLocator {
    static let singleton = ServiceLocator()
    let jsonService = JsonService.getJsonService()
    
    private init() {
        
    }
    
    static func getServiceLocator() -> ServiceLocator {
        return singleton
    }
    
    func getJsonService() -> JsonService {
        return jsonService
    }
    
}
