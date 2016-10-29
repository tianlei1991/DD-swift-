//
//  ItemTableViewCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation


extension CellType1 {
    
    func configureCell(model:ItemInfo) {
        
        self.itemImageView.alignmentRectInsets()
        
        self.itemImageView.sd_setImageWithURL(NSURL(string: model.cover_image_url)) { (image, _, _, _) in
            //需要在图片出来以后才能设置图片的拉伸比
            self.itemImageView.contentScaleFactor = UIScreen.mainScreen().scale
        }

        var title = ""
        
        for t in model.title {
            
            title += "\n"
            title += t
        }
        
        self.label_in_imageView?.text = title
    }
}