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
    
    var loginCompleted: (()->())!
    
    @IBAction func button(sender: AnyObject) {
        startVK()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private
    private func startVK() {
        
        let sdkInstance = VKSdk.initializeWithAppId(API.VK_ID)
        sdkInstance.registerDelegate(self)
        sdkInstance.uiDelegate = self
        VKSdk.authorize(API.SCOPE)
        
        if VKSdk.accessToken() != nil {
            
            loginCompleted()
        }
    }
    
    func goToAlbumsViewControler() {
        
        let vc = MainViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //MARK: VKSdkDelegate
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        
        if result.state == .Authorized || result.token != nil {
            loginCompleted()
        } else if result.state == .Error {
            let alert = UIAlertController(title: "Error", message: result.error.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresentViewController(controller: UIViewController!) {
        presentViewController(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(captchaError: VKError!) {
        print(captchaError)
    }
}
