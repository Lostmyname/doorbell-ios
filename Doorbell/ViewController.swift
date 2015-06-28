//
//  ViewController.swift
//  Doorbell
//
//  Created by Josh McMillan on 17/11/2014.
//  Copyright (c) 2014 Lost My Name. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var opener: UIButton!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackground()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openDoor() {
        DoorbellRequest.send()
    }
    
    func setBackground() {
        var sourceImage = UIImage(named: "background.jpg")
        let imageSize = sourceImage?.size
        let width = imageSize?.width
        let height = imageSize?.height
        let targetSize = self.view.frame.size
        let targetWidth = targetSize.width
        let targetHeight = targetSize.height
        var scaleFactor:CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPointMake(0.0, 0.0)
        
        if !CGSizeEqualToSize(imageSize!, targetSize) {
            let widthFactor  = targetWidth / width!
            let heightFactor = targetHeight / height!
            
            scaleFactor = widthFactor > heightFactor ? widthFactor : heightFactor
            
            scaledWidth = width! * scaleFactor
            scaledHeight = height! * scaleFactor
            
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }
            else if widthFactor < heightFactor {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
        var thumbnailRect = CGRectZero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        
        sourceImage?.drawInRect(thumbnailRect)
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: newImage)
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.setupIBeaconMonitoring()
    }
    
    func setupIBeaconMonitoring() {
        println("Start setting up monitoring")
        if (CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion)) {
            println("Can monitor regions")
        }
        var proximityUUID = NSUUID(UUIDString: "43BD5014-5743-463A-9B9F-A47ECA30DF51")
        var beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, identifier: "DoorBeacon")
        beaconRegion.notifyEntryStateOnDisplay = false
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = false
        self.locationManager.startMonitoringForRegion(beaconRegion)
        println("Finish setting up monitoring")
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        println("didDetermineState")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("didEnterRegion")
    }

}

