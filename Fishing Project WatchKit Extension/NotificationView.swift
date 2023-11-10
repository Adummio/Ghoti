//
//  NotificationView.swift
//  Fishing Project WatchKit Extension
//
//  Created by Fabbio on 08/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    
    let title: String?
    let message: String?
    
    init(title: String? = nil,
         message: String? = nil ){
        self.title = title
        self.message = message
    }
    //
    
    var body: some View {
        //
        VStack {
            
            
            
            Text(title ?? "Ghoti")
                .font(.headline)
                .lineLimit(0)
            
            Divider()
            
            Text(message ?? "Si proprj nu fish.")
                .font(.caption)
                .lineLimit(0)
        }
        //
    }
}
