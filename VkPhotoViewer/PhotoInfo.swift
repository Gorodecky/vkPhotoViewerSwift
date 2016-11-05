//
//  PhotoInfo.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/5/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit

class PhotoInfo: NSObject {
    
    var photoId: String
    var photoPreviewUrl: String
    var photoUrl: String
    var albumId: String
    var ownerId: String
    
    init(responseObject: NSDictionary) {
        
        photoId = responseObject["pid"] as! String
        photoPreviewUrl = responseObject["src_small"] as! String
        photoUrl = responseObject["src_big"] as! String
        albumId = responseObject["aid"] as! String
        ownerId = responseObject["owner_id"] as! String
    }
}
