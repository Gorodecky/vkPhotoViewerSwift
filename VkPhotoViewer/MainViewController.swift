//
//  MainViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/10/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import VK_ios_sdk

class MainViewController: UIViewController, VKSdkDelegate {
    
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    var albumsView: AlbumsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.albumView.hidden = false
        
        if VKSdk.initialized() {
            VKSdk.instance().registerDelegate(self)
        }
        
        checkSessionState()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "albums" {
            albumsView = segue.destinationViewController as? AlbumsViewController
        } else if segue.identifier == "loginSegue" {
            let loginVc = segue.destinationViewController as? LoginViewController
            loginVc?.loginCompleted = {
                self.checkSessionState()
            }
        }
        
    }
    
    private func checkSessionState() {
        
        VKSdk.wakeUpSession(API.SCOPE) { (state, error) -> Void in
            if state == VKAuthorizationState.Authorized {
                
                self.title = "Album list"
                self.albumView.hidden = false
                self.loginView.hidden = true
                self.albumsView!.getAlbums()
                
            } else if state == VKAuthorizationState.Initialized {
                
                self.title = "Login with VK"
                self.albumView.hidden = true
                self.loginView.hidden = false
                
            } else {
                print("error = \(error)")
            }
        }
    }
    
    
    //MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
    }
    
    func vkSdkUserAuthorizationFailed() {
    }
}
