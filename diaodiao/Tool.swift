//
//  Tool.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Tool: BaseType {
    
    
    var text    = ""
    var pic     = ""
    var type    = ""
    var val     = ""
//    "text": "生日礼物\n愿望单",
//    "pic": "http://content.image.alimmdn.com/feedusev3/1461295487.jpg",
//    "type": "link",
//    "val": "http://g3.diaox2.com:8000/bg/p_frt/"
    
    init (_ dict:JSON) {
        
        self.pic   = dict["pic"].stringValue
        self.text  = dict["text"].stringValue
        self.val   = dict["val"].stringValue
        self.type  = dict["type"].stringValue
        
    }
 
}
