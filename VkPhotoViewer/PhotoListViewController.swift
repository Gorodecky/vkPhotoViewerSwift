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
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var album : AlbumInfo?
    
    let identifierCell = "photoCollectionCellIdentifier"
    
    var nibMyCellLoaded: Bool?
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nibMyCellLoaded = false
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("preViewSegueIdentifier", sender: collectionView.cellForItemAtIndexPath(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(sender)
        if segue.identifier == "preViewSegueIdentifier" {
            let preViewVC = segue.destinationViewController as! PreviewImageViewController
            let cell = sender as! PhotoCollectionViewCell
            let indexPath = self.photoCollectionView.indexPathForCell(cell)
            preViewVC.album = album?.photos
            preViewVC.photo = album?.photos![(indexPath?.row)!]
            //let cell = sender as!
            
        }
    }
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (Request) {
        
        return Alamofire.request(.GET, urlString).responseImage { (response) -> Void in
            
            guard let image = response.result.value else {return}; completion(image)
        }
    }
}
