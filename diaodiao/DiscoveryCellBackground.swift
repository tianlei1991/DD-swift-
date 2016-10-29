//
//  DiscoveryCellBackground.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class DiscoveryCellBackground: UICollectionReusableView {
    
    let imageView:UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImage(named: "discover.bundle/bgypmohu.jpg")
        
        self.imageView.image = image
        self.imageView.frame = self.bounds
        self.addSubview(self.imageView)
//
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.redColor()
        
    }
        
}
