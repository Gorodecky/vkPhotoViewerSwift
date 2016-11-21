//
//  AlbumInfo.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/5/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit

class AlbumInfo: NSObject {
    
    var albumName: String
    var albumID: String
    var albumThumbID: String
    var albumUserID: String
    var albumPhotosCount: Int
    
    init(serverResponse: [String:AnyObject]) {
        
        albumName = serverResponse["title"] as! String
        albumID = serverResponse["aid"] as! String
        albumThumbID = serverResponse["thumb_id"] as! String
        albumUserID = serverResponse["owner_id"] as! String
        albumPhotosCount = serverResponse["size"] as! Int
    }

}
