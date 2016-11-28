//
//  PreviewImageViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/28/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class PreviewImageViewController: UIViewController {
    
    var album: [PhotoInfo]?
    
    var photo : PhotoInfo?
    
    @IBOutlet weak var imagePreView: UIImageView!
    @IBOutlet weak var indicatorPreview: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorPreview.hidden = true
        indicatorPreview.startAnimating()
        
        if photo != nil {
            updateWithPhotoInfo(photo!)
        }
    }
    
    func updateWithPhotoInfo(photoInfo: PhotoInfo) {
        print("photoInfo.photoPreviewUrl = \(photoInfo.photoPreviewUrl)")
        
        let urlString = (photoInfo.photoUrl) as String
        
        getNetworkImage(urlString, completion: { (image) -> Void in
            
            self.imagePreView.image = image
            self.indicatorPreview.stopAnimating()
            self.indicatorPreview.hidden = true
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
