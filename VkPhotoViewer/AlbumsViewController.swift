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

class AlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kPhotoPreviewCellIdentifier = "PreviewCellIdentifier"
    
    @IBOutlet weak var albumTableView: UITableView!
    
    var albumsArray : [AlbumInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getAlbums() {
        
        let method = "photos.getAlbums"
        let parametrs = ["user_id": VKSdk.accessToken().userId]
        let getRequest = VKRequest(method: method, parameters: parametrs, modelClass: nil)
        
        getRequest.executeWithResultBlock({ (response) -> Void in
            
            let json = JSON(response.json)
            
            if let items = json["items"].arrayObject {
                
                for item in items {
                    
                    let jsonItem = JSON(item)
                    let album = AlbumInfo(serverResponse: jsonItem)
                    
                    self.getPhotoInformationForAlbums(album, complection: {(photoInfo) -> () in
                        
                        if photoInfo != nil {
                            
                            album.photos = photoInfo! as [PhotoInfo]
                            album.albumPreview = photoInfo![0].photoUrl as String
                            self.albumsArray.append(album)
                        }
                        self.albumTableView.reloadData()
                    })
                }
            }
            }) { (error) -> Void in
                print("error = \(error)")
        }
    }
    
    func getPhotoInformationForAlbums(album: AlbumInfo, complection: ([PhotoInfo]?)->()) {
        
        var arrayPhoto = [PhotoInfo]()
        let methodAlbum = "photos.get"
        let parametrsAlbum = ["owner_id": VKSdk.accessToken().userId, "album_id": album.albumID]
        let getAlbumRequest = VKRequest(method: methodAlbum, parameters: parametrsAlbum, modelClass: nil)
        
        getAlbumRequest.executeWithResultBlock({ (response) -> Void in
            
            let jsonAlbum = JSON(response.json)["items"].arrayValue
            
            for photo in jsonAlbum {
                
                let item = PhotoInfo(responseObject: photo)
                
                arrayPhoto.append(item)
                
            }
            print(arrayPhoto.count)
            complection(arrayPhoto)
            
            }, errorBlock: { (error) -> Void in
                print(error)
        })
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("PhotoListIdentifier", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PhotoListIdentifier" {
            let photoListVC = segue.destinationViewController as! PhotoListViewController
            
            if let indexPath = self.albumTableView.indexPathForSelectedRow {
                let selectedAlbum = albumsArray[indexPath.row]
                photoListVC.album = selectedAlbum
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: PhotoPreviewCell = self.albumTableView.dequeueReusableCellWithIdentifier(kPhotoPreviewCellIdentifier) as! PhotoPreviewCell
        
        let album = self.albumsArray[indexPath.row]
        cell.updateWithAlbumInformation(album)
        
        return cell
    }
}
