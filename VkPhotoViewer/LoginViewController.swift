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
    
    let SCOPE = [VK_PER_PHOTOS]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func button(sender: AnyObject) {
        startVK()
    }
    
    func startVK() {
        
        let sdkInstance = VKSdk.initializeWithAppId(programID)
        sdkInstance.registerDelegate(self)
        sdkInstance.uiDelegate = self
        VKSdk.authorize(SCOPE)
        
        if VKSdk.accessToken() != nil {
            goToAlbumsViewControler()
        }
    }
    
    func goToAlbumsViewControler() {
        
        let vc = MainViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinishedWithResult(result: VKAuthorizationResult!) {
        
        //let token = VKSdk.accessToken().accessToken
        //print("token = \(token)")
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
