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
    class func send() {
        println("Boo")
//        Alamofire.request(.POST, "https://lostmydoorbell.herokuapp.com/", parameters: [
//            "token": self.slackToken(),
//            "user_name": UIDevice.currentDevice().name
//        ])
    }
    
    class func slackToken() -> AnyObject {
        let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist")
        let settings = NSDictionary(contentsOfFile: path!)!
        
        return settings["SlackToken"]!
    }
}
