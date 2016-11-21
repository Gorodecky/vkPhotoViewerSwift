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


class AlbumsViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    var albumsArray : [AlbumInfo] = []
    var albumsDict = [NSDictionary]()

    
    //@IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    func getAlbums() {
        
        let method = "photos.getAlbums"
        let parametrs = ["user_id": VKSdk.accessToken().userId]
        
        let getRequest = VKRequest(method: method, parameters: parametrs, modelClass: nil)
        
        getRequest.executeWithResultBlock({ (response) -> Void in
            
            if response != nil {
                let items = response.json as! NSDictionary
                
                let albums = items.valueForKey("items") as! NSArray
                
                print("albums = \(albums.count)")
                
                for album in albums {
                    
                    
                }
                
            //self.albumsDict = response.json as! [NSDictionary]
                
                
            
            }
            
            
            }) { (error) -> Void in
                print("error = \(error)")
        }
    }
    
    func getPhotoInformationForAlbums() {
       /*
        for var album in self.albumsArray {
            
            album = AlbumInfo(serverResponse: <#T##NSDictionary#>)
            
            albumsArray.append(album)
            
        }
        */
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
