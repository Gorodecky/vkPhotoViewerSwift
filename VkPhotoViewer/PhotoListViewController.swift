//
//  PhotoListViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/24/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var photoPreView: UIView!
    @IBOutlet weak var indicatorPreView: UIActivityIndicatorView!
    @IBOutlet weak var imagePreView: UIImageView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    //@IBOutlet weak var navigationBar: UINavigationBar!
    
    var album : AlbumInfo?
    let identifierCell = "photoCollectionCellIdentifier"
    var nibMyCellLoaded: Bool?
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationBar.hidden = false
        nibMyCellLoaded = false
        photoPreView.hidden = true
        
        //titleNavigationItem.title = album!.albumName
        
        photoCollectionView.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: identifierCell)
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (album?.photos?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if nibMyCellLoaded == false {
            
            let nib : UINib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
            
            collectionView.registerNib(nib, forCellWithReuseIdentifier: identifierCell)
            
            nibMyCellLoaded = true
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifierCell, forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        
        let photo = album?.photos![indexPath.row]
        
        cell.udateWithPhotoInfo(photo!)
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //print("indexPath.row = \(indexPath.row)")
        
        //self.navigationBar.hidden = true
        self.photoPreView.hidden = false
        self.photoCollectionView.hidden = true
        self.indicatorPreView.hidden = false
        self.indicatorPreView.startAnimating()
        loadPhotoWithFullSizePreview((album?.photos![indexPath.row])!)
    }
    
    func loadPhotoWithFullSizePreview (photoInfo:PhotoInfo) {
        
        let urlString = photoInfo.photoUrl
        
        getNetworkImage(urlString) { (image) -> Void in
            self.imagePreView.image = image
            self.indicatorPreView.stopAnimating()
        }
    }
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (Request) {
        
        return Alamofire.request(.GET, urlString).responseImage { (response) -> Void in
            
            guard let image = response.result.value else {return}; completion(image)
        }
    }
    
    // MARK: CloseButton
    @IBAction func closeButtonPreView(sender: AnyObject) {
        self.photoPreView.hidden = true
        self.photoCollectionView.hidden = false
        //self.navigationBar.hidden = false
    }
}
