//
//  DiscoveryTableCell.swift
//  diaodiao
//
//  Created by honey on 16/5/11.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class DiscoveryTableCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    typealias Callback = (_:Node)->Void
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundImageBlur: UIImageView!
    
    @IBOutlet weak var collectionTitle: UILabel!
    var model:Discovery?
    
    var didCollectionViewItemSelected:Callback?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
