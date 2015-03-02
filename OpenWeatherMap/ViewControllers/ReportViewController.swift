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
    @IBOutlet weak private var mapWidth: NSLayoutConstraint!
    let locationManager = CLLocationManager();
    let cartoDB_API = "88a4a6d71419e6fe522a6302c8e9ace7004d8953";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempField.attributedPlaceholder = NSAttributedString(string:"Temperature (ºC)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        rainField.attributedPlaceholder = NSAttributedString(string:"Air humidity (%)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        humidField.attributedPlaceholder = NSAttributedString(string:"Soil humidity (%)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])

        self.addPadding(tempField)
        self.addPadding(rainField)
        self.addPadding(humidField)
        
        let toolbarTemp = UIToolbar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 44))
        let toolbarRain = UIToolbar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 44))
        let toolbarHumid = UIToolbar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 44))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil)

        let toRainButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "toRainfall")
        let toHumidButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target:self, action: "toHumidity")
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Done, target:self, action: "dismissKeyboard")
        
        toolbarTemp.items = [flexSpace, toRainButton]
        toolbarRain.items = [flexSpace, toHumidButton]
        toolbarHumid.items = [flexSpace, doneButton]
        
        tempField.inputAccessoryView = toolbarTemp
        rainField.inputAccessoryView = toolbarRain
        humidField.inputAccessoryView = toolbarHumid
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        mapWidth.constant = UIScreen.mainScreen().bounds.width - 40
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendReport() {
        let temp = (tempField.text as NSString).floatValue
        let humidity = (humidField.text as NSString).floatValue
        let rainfall = (rainField.text as NSString).floatValue
        
        let urlString = "http://ygneo.cartodb.com/api/v2/sql?q=UPDATE iot_demo_1 SET temperatur=\(temp), humidity=\(humidity), rainfall=\(rainfall) WHERE id_rec='25061:0:0:7:127:1'&api_key=\(cartoDB_API)"
        let url = NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!);
        let request = NSURLRequest(URL: url!);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
            var title = "Report sent"
            var message = "Your weather report was sent successfully!"
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            })
            
            if let anError = error {
                title = "Error sending report"
                message = "There was an error sending your weather report. Please, try again in a few minutes";
            }

            var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
            alert.addAction(action);
            [self .presentViewController(alert, animated: true, completion: { () -> Void in
            })];
        }
    }
    
    // MARK: Private methods
    
    private func addPadding(textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.Always;
        textField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10));
    }
    
    func toRainfall() {
        rainField.becomeFirstResponder()
    }
    
    func toHumidity() {
        humidField.becomeFirstResponder()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true);
        self.sendReport()
    }
    
    // MARK: Location manager delegate
    
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
        locationMap.setRegion(MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.01, 0.01)), animated: true)
        if (locationObj.horizontalAccuracy < 50) {
            locationManager.stopUpdatingLocation()
        }
    }
}
