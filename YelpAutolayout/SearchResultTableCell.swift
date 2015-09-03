//
//  SearchResultTableCell.swift
//  YelpAutolayout
//
//  Created by Tommy Chheng on 9/1/15.
//  Copyright (c) 2015 Tommy Chheng. All rights reserved.
//

import Foundation
import UIKit

class SearchResultTableCell: UITableViewCell {
    @IBOutlet weak var photoThumbView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override func awakeFromNib() {
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
    }
}
