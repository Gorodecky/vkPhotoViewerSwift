//
//  PhotoListViewController.swift
//  VkPhotoViewer
//
//  Created by Vitaliy on 11/24/16.
//  Copyright © 2016 Vitaliy. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var album : [PhotoInfo] = []
    var nibMyCellLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        print(album.count)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCellIdentifier", forIndexPath: indexPath)
        
        cell.backgroundView?.backgroundColor = UIColor.blueColor()
        return cell
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
