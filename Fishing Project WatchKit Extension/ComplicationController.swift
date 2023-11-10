//
//  ComplicationController.swift
//  a WatchKit Extension
//
//  Created by Fabbio on 22/01/2020.
//  Copyright © 2020 Fabbio. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        switch complication.family {
        
        case .graphicRectangular:
            let rectangularTemplate = CLKComplicationTemplateGraphicRectangularTextGauge()


            let headerText = CLKSimpleTextProvider(text: "You're Fishing.")
            headerText.tintColor = UIColor(red: 0/255.0, green: 148/255.0, blue: 250/255.0, alpha: 1.0)
            rectangularTemplate.headerTextProvider = headerText


            let bodyText = CLKSimpleTextProvider(text: "Walk a bit more!")
            bodyText.tintColor = .white
            rectangularTemplate.body1TextProvider = bodyText


            let gaugeColor = UIColor(red: 0/255.0, green: 148/255.0, blue: 250/255.0, alpha: 1.0)
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .fill,
                                       gaugeColor: gaugeColor,
                                       fillFraction: 0.2)
            rectangularTemplate.gaugeProvider = gaugeProvider
            let entry = CLKComplicationTimelineEntry(date: Date(),
                                                     complicationTemplate: rectangularTemplate)
            handler(entry)
        default:
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        switch complication.family {
        
        case .graphicRectangular:

            let rectangularTemplate = CLKComplicationTemplateGraphicRectangularTextGauge()

            let headerText = CLKSimpleTextProvider(text: "You're Fishing.")
            headerText.tintColor = UIColor(red: 116.0/255.0, green: 192.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            rectangularTemplate.headerTextProvider = headerText

            let bodyText = CLKSimpleTextProvider(text: "Walk a bit more!")
            bodyText.tintColor = .white
            rectangularTemplate.body1TextProvider = bodyText

            let gaugeColor = UIColor(red: 116.0/255.0, green: 192.0/255.0, blue: 58.0/255.0, alpha: 1.0)
            let gaugeProvider =
                CLKSimpleGaugeProvider(style: .fill,
                                       gaugeColor: gaugeColor,
                                       fillFraction: 0.5)
            rectangularTemplate.gaugeProvider = gaugeProvider
            handler(rectangularTemplate)
        default:
            handler(nil)
        }
    }
}
