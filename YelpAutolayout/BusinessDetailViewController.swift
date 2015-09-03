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

class BusinessDetailViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    var business:Business?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.dataSource = self
        
        updateData()
    }
    
    //MARK: Data
    func updateData() {
        if let b = self.business {
            if let i = b.id {                
                Business.get(i, completion: {
                    (b: Business!, error: NSError!) -> Void in
                    self.business = b
                    self.collectionView.reloadData()
                })
            }
        }
    }

    //MARK: Collection View
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if let b = self.business {
            if let r = b.reviews {
                return r.count
            } else {
                return 0
            }
        } else {
            return 0
        }
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
            "ReviewCell", forIndexPath: indexPath) as! ReviewCollectionCell

        if let r = self.business?.reviews {
            cell.excerptLabel?.text = r[indexPath.row]
        }
        
        return cell
    }

}