//
//  AlbumsViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/5/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import VK_ios_sdk
import Foundation
import SwiftyJSON


class AlbumsViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    var albumsArray : [AlbumInfo] = []
    
    //@IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    func getAlbums() {
        ///////////////////////////////////
        let method = "photos.getAlbums"
        let parametrs = ["user_id": VKSdk.accessToken().userId]
        
        let getRequest = VKRequest(method: method, parameters: parametrs, modelClass: nil)
        
        getRequest.executeWithResultBlock({ (response) -> Void in
            let json = JSON(response.json)
            
            if let items = json["items"].arrayObject {
                
                for item in items {
                    let jsonItem = JSON(item)
                    self.albumsArray.append(AlbumInfo(serverResponse: jsonItem))
                    
                }
                self.getPhotoInformationForAlbums()

            }
            
            print("self.albumsArray.count = \(self.albumsArray.count)")
    
            }) { (error) -> Void in
                print("error = \(error)")
        }
    }
    
    func getPhotoInformationForAlbums() {
        
        for album in self.albumsArray {
            
            let methodAlbum = "photos.get"
            let parametrsAlbum = ["owner_id": VKSdk.accessToken().userId,
            "album_id": album.albumID]
            
            let getAlbumRequest = VKRequest(method: methodAlbum, parameters: parametrsAlbum, modelClass: nil)
            
            getAlbumRequest.executeWithResultBlock({ (response) -> Void in
                
                let jsonAlbum = JSON(response.json)
                
                print("jsonAlbum = \(jsonAlbum)")
            
                }, errorBlock: { (error) -> Void in
                    print(error)
            })
            
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
