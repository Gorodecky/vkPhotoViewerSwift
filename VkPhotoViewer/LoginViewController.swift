//
//  LoginViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/4/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import VK_ios_sdk


class LoginViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {
    
    let programID = "5185911"
    
    let scope = [ VK_PER_WALL, VK_PER_PHOTOS]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startVK()
        button(self)
        
        VKSdk.wakeUpSession(scope) { (state, error) -> Void in
            
            if state == .Authorized {
                print("state = \(state.hashValue.description)")
                
                
            } else if error != nil {
                print("error = \(error)")
            } else {
                print("Not authorize!!!")
                //let scopePermissions = ["email", "wall", "photos"]
                
                if VKSdk.vkAppMayExists() == true {
                    
                    VKSdk.authorize(self.scope, withOptions: .UnlimitedToken)
                } else {
                    VKSdk.authorize(self.scope, withOptions: [.DisableSafariController, .UnlimitedToken])
                }
            }
        }
    }
    @IBAction func button(sender: AnyObject) {
        VKSdk.authorize(scope)
        print("sender = \(sender)")
        
    }
    
    func startVK() {
        
        let sdk = VKSdk.initializeWithAppId(programID)
        sdk.registerDelegate(self)
        
        sdk.uiDelegate = self
        
    }
    
    //PRAGMA MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        let rezult = VKAuthorizationResult()
        
        print("rezult \(rezult)")
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        
        self.navigationController?.presentViewController(controller, animated: true, completion: nil)
        
        //self.navigationController?.showViewController(controller, sender: nil)
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        print(captchaError)
    }
    
}



