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
    
    let programID = "5185911"
    
    let SCOPE = [VK_PER_PHOTOS]
    
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    var albumsView: AlbumsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.albumView.hidden = false
        
        let sdkInstance = VKSdk.initializeWithAppId(programID)
        
        sdkInstance.registerDelegate(self)
        
        VKSdk.wakeUpSession(SCOPE) { (state, error) -> Void in
            
            if state == VKAuthorizationState.Authorized {
                
                self.albumView.hidden = false
                self.loginView.hidden = true
                self.albumsView!.getAlbums()
                
            } else if state == VKAuthorizationState.Initialized {
                self.albumView.hidden = true
                self.loginView.hidden = false
                print("Initialized")
            } else {
                print("error = \(error)")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "albums" {
            albumsView = segue.destinationViewController as? AlbumsViewController
        }
    }
    
    //MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
    }
    
    func vkSdkUserAuthorizationFailed() {
    }
}
