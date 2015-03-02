//
//  ReportViewController.swift
//  OpenWeatherMap
//
//  Created by Javi Dolcet Figueras on 01/03/15.
//  Copyright (c) 2015 Teanamics. All rights reserved.
//

import UIKit
import MapKit

class ReportViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak private var tempField: UITextField!
    @IBOutlet weak private var humidField: UITextField!
    @IBOutlet weak private var rainField: UITextField!
    @IBOutlet weak private var locationMap: MKMapView!
    let locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempField.attributedPlaceholder = NSAttributedString(string:"Temperature (ºC)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        humidField.attributedPlaceholder = NSAttributedString(string:"Soil humidity (%)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        rainField.attributedPlaceholder = NSAttributedString(string:"Rainfall (mm/m²)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])

        self.addPadding(tempField)
        self.addPadding(humidField)
        self.addPadding(rainField)
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 44))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Done, target:self, action: "dismissKeyboard:");
        toolbar.items = [flexSpace, doneButton]
        
        tempField.inputAccessoryView = toolbar
        humidField.inputAccessoryView = toolbar
        rainField.inputAccessoryView = toolbar
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addPadding(textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.Always;
        textField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10));
    }
    
    func dismissKeyboard(sender: UIControl) {
        self.view.endEditing(true);
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        locationManager.stopUpdatingLocation()
        if ((error) != nil) {
            print(error)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        println(coord.latitude)
        println(coord.longitude)
    }
}
