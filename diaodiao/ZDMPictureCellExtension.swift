//
//  ZDMPictureCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation


extension ZDMPictureCell {
    
    func configureCell(model:ZDM) -> Void {
        

        self.price.text = model.price
        self.title.text = model.title.first
        
        self.site.text = model.buylink_site  + " " + model.pub_time_d
        self.icon.sd_setImageWithURL(NSURL(string: model.thumb_image_url), placeholderImage: UIImage(named: "photoPlaceholder"))
        
    }
}