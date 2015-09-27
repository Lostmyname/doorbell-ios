//
//  TodayViewController.swift
//  DoorbellExt
//
//  Created by Simon Fry on 04/05/2015.
//  Copyright (c) 2015 Lost My Name. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var letMeInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letMeInButton.layer.cornerRadius = 5
        letMeInButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        letMeInButton.alpha = 0.5
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openDoor() {
        DoorbellRequest.send()
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsMake(defaultMarginInsets.top, defaultMarginInsets.left, 10.0, defaultMarginInsets.right)
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
