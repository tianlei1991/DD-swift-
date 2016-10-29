//
//  ItemTableViewCell.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class CellType1: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var label_in_imageView: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
      
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
