//
//  PhotoCollectionViewCell.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/25/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        indicator.hidden = false
        indicator.startAnimating()
    }
    
    func udateWithPhotoInfo(photoInfo: PhotoInfo) {
        //print("photoInfo.photoPreviewUrl = \(photoInfo.photoPreviewUrl)")
        
        //indicator.startAnimating()
        let urlString = (photoInfo.photoPreviewUrl) as String
        
        getNetworkImage(urlString, completion: { (image) -> Void in
            
            self.photoImage.image = image
            self.indicator.stopAnimating()
            self.indicator.hidden = true
        })
    }
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (Request) {
        
        return Alamofire.request(.GET, urlString).responseImage { (response) -> Void in
            
            guard let image = response.result.value
                
                else { return }
            completion(image)
        }
    }
}
