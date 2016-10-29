//
//  ZDM.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ZDM {
    
    var ctype           = 0
    var latest_version  = 0
    
    var pub_time        = ""
    
    var url             = ""
    var price           = ""
    var cid             = ""
    var buylink_site    = ""
    var buylink         = ""
    var thumb_image_url = ""
    var summary         = ""
    
    var has_buylink     = false
    
    var title           = [String]()
    var author          = [String:String]()
    
    var pub_time_d :String {
        get {
            
            var ret = ""
            
            let cal = NSCalendar.currentCalendar()
            let pubtime = NSDate(timeIntervalSince1970: Double(self.pub_time)!)
            let now = NSDate()
            
            let pubComponents = cal.components([.Day, .Month, .Hour, .Minute], fromDate: pubtime)
            let nowCompents   = cal.components([.Day, .Month, .Hour, .Minute], fromDate: now)
            
            if pubComponents.day - nowCompents.day != 0 {
                
                ret = String(format: "%02d-%02d", pubComponents.month, pubComponents.day)
            }
            else
            {
                ret = String(format: "%02d:%02d", pubComponents.hour, pubComponents.minute)
            }
            
            
            return ret
        }
    }

    init (json:JSON) {
        self.buylink         = json["buylink"].stringValue
        self.buylink_site    = json["buylink_site"].stringValue
        self.cid             = json["cid"].stringValue
        self.ctype           = json["ctype"].intValue
        self.has_buylink     = json["has_buylink"].boolValue
        self.latest_version  = json["latest_version"].intValue
        self.price           = json["price"].stringValue
        self.pub_time        = json["pub_time"].stringValue
        self.summary         = json["summary"].stringValue
        self.thumb_image_url = json["thumb_image_url"].stringValue
        
        self.url             = json["url"].stringValue
        
        for t in json["title"].arrayValue {
            self.title.append(t.stringValue)
        }
        
        for (k, v) in json["author"].dictionaryValue {
            self.author[k] = v.stringValue
        }
    }
}






