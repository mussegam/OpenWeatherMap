//
//  ReportViewController.swift
//  OpenWeatherMap
//
//  Created by Javi Dolcet Figueras on 01/03/15.
//  Copyright (c) 2015 Teanamics. All rights reserved.
//

import UIKit
import MapKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak private var tempField: UITextField!
    @IBOutlet weak private var humidField: UITextField!
    @IBOutlet weak private var rainField: UITextField!
    @IBOutlet weak private var locationMap: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tempField.attributedPlaceholder = NSAttributedString(string:"Temperature (ºC)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()]);
        humidField.attributedPlaceholder = NSAttributedString(string:"Soil humidity (kPa)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()]);
        rainField.attributedPlaceholder = NSAttributedString(string:"Rainfall (mm/m²)", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()]);

        self.addPadding(tempField);
        self.addPadding(humidField);
        self.addPadding(rainField);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addPadding(textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.Always;
        textField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10));
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
