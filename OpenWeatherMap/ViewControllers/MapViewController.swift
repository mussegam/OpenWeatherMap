//
//  MapViewController.swift
//  OpenWeatherMap
//
//  Created by Javi Dolcet Figueras on 01/03/15.
//  Copyright (c) 2015 Teanamics. All rights reserved.
//

import UIKit
import WebKit

class MapViewController: UIViewController {
    
    private var webView: WKWebView?;
    
    override func loadView() {
        self.webView = WKWebView()
        
        //self.webView!.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "http://openweathermap.agroptima.com/")
        let request = NSURLRequest(URL: url!)
        self.webView!.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
