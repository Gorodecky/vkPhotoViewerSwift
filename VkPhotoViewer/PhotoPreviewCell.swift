//
//  PhotoPreviewCell.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/22/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import VK_ios_sdk
import Alamofire
import AlamofireImage

class PhotoPreviewCell: UITableViewCell {
    
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumIndicator: UIActivityIndicatorView!
    @IBOutlet weak var AlbumLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateWithAlbumInformation (album: AlbumInfo) {
        AlbumLable.text = album.albumName
        albumIndicator.hidden = false
        albumIndicator.startAnimating()
        albumImageView.clipsToBounds = true
        
        
        
        print("album = \(album.albumID) image = \(album.albumPreview)")
        
        
        
        if album.albumPreview != nil {
            
            let urlString = (album.albumPreview)! as String
            
            getNetworkImage(urlString, completion: { (image) -> Void in
                
                self.albumImageView.image = image
                self.albumIndicator.stopAnimating()
                self.albumIndicator.hidden = true
            })
        }
    }
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (Request) {
        
        return Alamofire.request(.GET, urlString).responseImage { (response) -> Void in
            
            guard let image = response.result.value
                
            else {
        return }
            completion(image)
        }
    }
    
}
