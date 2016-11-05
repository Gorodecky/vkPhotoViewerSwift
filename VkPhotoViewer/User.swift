//
//  User.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/5/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userFirstName: String
    var userLastName: String
    var userID: String
    
    init(responseObject: NSDictionary) {
                
        userFirstName = responseObject["first_name"] as! String
        userLastName = responseObject["last_name"] as! String
        userID = responseObject["uid"] as! String
        
    }

}
