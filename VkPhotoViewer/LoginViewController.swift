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
    
    let scope = [VK_PER_WALL, VK_PER_PHOTOS]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button(self)
    }
    
    
    @IBAction func button(sender: AnyObject) {
        print("sender = \(sender)")
        
        let sdk = VKSdk.initializeWithAppId(programID)
        sdk.registerDelegate(self)
        sdk.uiDelegate = self
        VKSdk.authorize(scope)
                
        startVK()
        
    }
    
    func startVK() {
        
        VKSdk.wakeUpSession(scope) { (state, error) -> Void in
            switch state {
            case .Authorized: print("authorize")
            case .Initialized: print("inicializer")
            default : print("error")
            }
        }
    }
    /*5) Check if user already authorized.
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
    switch (state) {
    case VKAuthorizationAuthorized:
    // User already autorized, and session is correct
    break;
    
    case VKAuthorizationInitialized:
    // User not yet authorized, proceed to next step
    break;
    
    default:
    // Probably, network error occured, try call +[VKSdk wakeUpSession:completeBlock:] later
    break;
    }
    }];
    
    6) If user is not authorized, call +[VKSdk authorize:] method with required scope (permission for token you required).
    
    [VKSdk authorize:@[VK_PER_FRIENDS, VK_PER_WALL]];
    
    7) You wait for -[VKSdkDelegate vkSdkAccessAuthorizationFinishedWithResult:] method called.
    
    - (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
    // User successfully authorized, you may start working with VK API
    } else if (result.error) {
    // User canceled authorization, or occured unresolving networking error. Reset your UI to initial state and try authorize user later
    }
    }
    
    */

    
    //PRAGMA MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        if result.token != nil {
            print("token = \(result.token.accessToken) state = \(result.state)")
        } else {
            print("error")
        }
        

    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        
        //self.navigationController?.presentViewController(controller, animated: true, completion: nil)
        
        self.navigationController?.showViewController(controller, sender: nil)
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        print(captchaError)
    }
    
}



