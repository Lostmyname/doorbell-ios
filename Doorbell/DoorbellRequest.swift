//
//  DoorbellRequest.swift
//  Doorbell
//
//  Created by Josh McMillan on 17/11/2014.
//  Copyright (c) 2014 Lost My Name. All rights reserved.
//

import UIKit
import Alamofire

class DoorbellRequest: NSObject {
    class func send(source: String = "iOS") {
        Alamofire.request(.POST, "https://lostmydoorbell.herokuapp.com/", parameters: [
            "token": self.slackToken(),
            "user_name": "\(UIDevice.currentDevice().name) (\(source))"
        ])
    }
    
    class func sendWithGuard(source: String = "iOS") {
        if (self.allowedToBuzzInBackground() && self.isInOfficeHours()) {
            self.send(source: source)
        }
    }
    
    class func slackToken() -> AnyObject {
        let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist")
        let settings = NSDictionary(contentsOfFile: path!)!
        
        return settings["SlackToken"]!
    }
    
    class func allowedToBuzzInBackground() -> Bool {
        let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist")
        let settings = NSDictionary(contentsOfFile: path!)!
        
        return settings["CanSendBackgroundBuzz"] as! Bool
    }
    
    class func isInOfficeHours() -> Bool {
        let now = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar?.timeZone = NSTimeZone(name: "Europe/London")!
        let weekday = calendar?.component(.CalendarUnitWeekday, fromDate: now)
        let hour = calendar?.component(.CalendarUnitHour, fromDate: now)
        
        let inWorkWeek = weekday > 1 && weekday < 7
        let inWorkDay = hour > 7 && hour < 20
        
        return inWorkDay && inWorkWeek
    }
}
