//
//  ZDMCell.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class ZDMListCell: UITableViewCell {
    
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var site:UILabel!
    @IBOutlet weak var pub_time:UILabel!
    @IBOutlet weak var price:UILabel!
    @IBOutlet weak var desc:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
