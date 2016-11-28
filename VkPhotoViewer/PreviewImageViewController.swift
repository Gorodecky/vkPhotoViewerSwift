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
    var photoIndex: Int?
    
    @IBOutlet weak var imagePreView: UIImageView!
    @IBOutlet weak var indicatorPreview: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(photoIndex)
        createSwipes()
        indicatorPreview.hidden = true
        indicatorPreview.startAnimating()
        
        updateWithPhotoInfo(album![photoIndex!])
    }
    
    
    //MARK: Create and register Swipes to left and to right
    func createSwipes () {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeHorizontal:")
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeHorizontal:")
        
        swipeLeft.direction = .Left
        swipeRight.direction = .Right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func swipeHorizontal(sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == .Left) {
            
            photoIndex = photoIndex! + 1
            
            if photoIndex > ((album?.count)! - 1) {
                photoIndex = 0
            }
            
            updateWithPhotoInfo(album![photoIndex!])
            
        } else if (sender.direction == .Right) {
            
            photoIndex = photoIndex! - 1
            
            if photoIndex < 0 {
                photoIndex = (album?.count)! - 1
            }
            
            updateWithPhotoInfo(album![photoIndex!])
        }
    }
    
    // MARK: download photo with image
    func updateWithPhotoInfo(photoInfo: PhotoInfo) {
        //print("photoInfo.photoPreviewUrl = \(photoInfo.photoPreviewUrl)")
        
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
