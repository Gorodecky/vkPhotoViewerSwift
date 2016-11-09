//
//  LoginViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/4/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import SwiftyVK

class LoginViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        let webView = UIWebView(frame: rect)
        
        self.view.addSubview(webView)
        
        
        

    }

    

}
