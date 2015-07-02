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
    
    class func slackToken() -> AnyObject {
        let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist")
        let settings = NSDictionary(contentsOfFile: path!)!
        
        return settings["SlackToken"]!
    }
}
