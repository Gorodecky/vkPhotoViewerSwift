//
//  PhotoListViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/24/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var photoPreView: UIView!
    @IBOutlet weak var indicatorPreView: UIActivityIndicatorView!
    @IBOutlet weak var imagePreView: UIImageView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var album : AlbumInfo?
    let identifierCell = "photoCollectionCellIdentifier"
    var nibMyCellLoaded: Bool?

    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        nibMyCellLoaded = false
        super.viewDidLoad()
        photoPreView.hidden = true
        
        print(album!.photos?.count)
        titleNavigationItem.title = album!.albumName
        
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
    
    
    // MARK: CloseButton
    @IBAction func closeButtonPreView(sender: AnyObject) {
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
