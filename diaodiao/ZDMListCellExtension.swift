//
//  ZDMListCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation

extension ZDMListCell {
    
    func configureCell(model:ZDM) -> Void {
        
        self.pub_time.text = model.author["name"]! + " " + model.pub_time_d
        self.price.text = model.price
        self.title.text = model.title.first
        
        self.site.text = model.buylink_site
        self.icon.sd_setImageWithURL(NSURL(string: model.thumb_image_url), placeholderImage: UIImage(named: "photoPlaceholder"))
        
        self.desc.text = model.summary
    }
    
}