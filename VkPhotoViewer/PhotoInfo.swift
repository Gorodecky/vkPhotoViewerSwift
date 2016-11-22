//
//  PhotoInfo.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/5/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import SwiftyJSON

class PhotoInfo: NSObject {
    
    var photoId: String
    var photoPreviewUrl: String
    var photoUrl: String
    var albumId: String
    var ownerId: String
    
    init(responseObject: JSON) {
        
        photoId = responseObject["pid"].stringValue
        photoPreviewUrl = responseObject["src_small"].stringValue
        photoUrl = responseObject["src_big"].stringValue
        albumId = responseObject["aid"].stringValue
        ownerId = responseObject["owner_id"].stringValue
    }
}
