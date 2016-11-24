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
        
        photoId = responseObject["id"].stringValue
        photoPreviewUrl = responseObject["photo_75"].stringValue
        photoUrl = responseObject["photo_604"].stringValue
        albumId = responseObject["album_id"].stringValue
        ownerId = responseObject["owner_id"].stringValue
    }
}
