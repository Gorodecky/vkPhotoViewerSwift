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
    
    var albumsArray  = [NSArray]()

    //@IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    func getAlbums() {
        
        let method = "photos.getAlbums"
        let parametrs = ["user_id": VKSdk.accessToken().userId]
        
        let getRequest = VKRequest(method: method, parameters: parametrs, modelClass: nil)
        
        getRequest.executeWithResultBlock({ (response) -> Void in
            
            if response.json.count > 0 {
                
                let jsonAlbums = JSON(response.json)
                
                self.albumsArray = jsonAlbums["items"].arrayObject as! [NSArray]
                
                for album in self.albumsArray {
                    
                    print(album)
                }
            
            
            
            
            }
    
            }) { (error) -> Void in
                print("error = \(error)")
        }
    }
    /*
    func getPhotoInformationForAlbums(array : [NSArray]) {
        
        for var album in array  {
            
            album = AlbumInfo(serverResponse: <#T##[String : AnyObject]#>)
            
            albumsArray.append(album)
            
        }
        
    }
*/
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
