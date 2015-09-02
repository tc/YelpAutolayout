//
//  BusinessDetailViewController.swift
//  YelpAutolayout
//
//  Created by Tommy Chheng on 9/2/15.
//  Copyright (c) 2015 Tommy Chheng. All rights reserved.
//

import Foundation
import UIKit

class BusinessDetailHeaderView: UICollectionReusableView {
    @IBOutlet weak var photoThumbView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}

class ReviewCell: UICollectionViewCell {

}

class BusinessDetailViewController: UIViewController, UICollectionViewDataSource {
    var business:Business?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.dataSource = self
    }

    //MARK - Collection View
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            //1
            switch kind {
                //2
            case UICollectionElementKindSectionHeader:
                //3
                let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "BusinessDetailHeaderView",
                    forIndexPath: indexPath)
                    as! BusinessDetailHeaderView
                
                if let b = self.business {
                    headerView.titleLabel.text = b.name
                    headerView.photoThumbView.setImageWithURL(b.imageURL)
                    
                }
                
                return headerView
            default:
                //4
                assert(false, "Unexpected element kind")
            }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "ReviewCell", forIndexPath: indexPath) as! UICollectionViewCell

        
        return cell
    }

}