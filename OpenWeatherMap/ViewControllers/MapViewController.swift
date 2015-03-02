//
//  MapViewController.swift
//  OpenWeatherMap
//
//  Created by Javi Dolcet Figueras on 01/03/15.
//  Copyright (c) 2015 Teanamics. All rights reserved.
//

import UIKit
import WebKit

class MapViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView?;
    @IBOutlet weak private var loadingView: UIView!;
    
    override func loadView() {
        self.webView = WKWebView()
        self.webView!.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.loadingView);
        view.addConstraint(NSLayoutConstraint(item: loadingView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0));
        view.addConstraint(NSLayoutConstraint(item: loadingView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0));
        
        self.loadingView.layer.cornerRadius = 4;
        
        let url = NSURL(string: "http://openweathermap.agroptima.com/")
        let request = NSURLRequest(URL: url!)
        self.webView!.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        loadingView.hidden = true;
    }

}
