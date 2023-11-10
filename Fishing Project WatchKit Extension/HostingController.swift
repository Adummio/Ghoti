//
//  HostingController.swift
//  Fishing Project WatchKit Extension
//
//  Created by Fabbio on 08/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView> {
    
    public static let singleton = HostingController()
    
    override var body: ContentView {
        return ContentView()
    }
    
    
    public static func getController() -> HostingController{
        return self.singleton
    }

}
