//
//  AlbumInfo.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/5/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import SwiftyJSON


class AlbumInfo: NSObject {
    
    var albumName: String
    var albumID: String
    var albumThumbID: String
    var albumUserID: String
    var albumPhotosCount: Int
    
    init(serverResponse: JSON) {
        
        albumName = serverResponse["title"].stringValue
        albumID = serverResponse["id"].stringValue
        albumThumbID = serverResponse["thumb_id"].stringValue
        albumUserID = serverResponse["owner_id"].stringValue
        albumPhotosCount = serverResponse["size"].intValue
    }

}
