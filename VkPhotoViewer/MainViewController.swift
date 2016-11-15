//
//  MainViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/10/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumView.hidden = true
        self.loginView.hidden = false
        
    }
    
    
}
