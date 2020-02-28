//
//  webViewController.swift
//  terem
//
//  Created by svitlana vykhor on 25/02/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import UIKit
import WebKit
class webViewController: UIViewController, WKUIDelegate {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        let myURL = URL(string:"https://earthquake.usgs.gov")
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)

        
    }
    

    
}
