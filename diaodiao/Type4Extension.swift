//
//  Type2Extension.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation


extension CellType4 {
    
    func configureCell(model:ItemInfo) -> Void {
        
        
        var url:String = ""
        
        switch model.ctype {
        case 4:
            url = model.coverv3
        default:
            url = model.cover_image_url
        }
        
        
        
       
        var title = ""
        
        for t in model.title {
            title += t
        }
       
        self.title.text = title
        
        self.itemImageView.sd_setImageWithURL(NSURL(string: url)) { (_, _, _, _) in
//            需要在图片出来以后才能设置图片的拉伸比
            self.itemImageView.contentScaleFactor = UIScreen.mainScreen().scale
        }
    }
}