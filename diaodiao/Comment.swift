//
//  Comment.swift
//  diaodiao
//
//  Created by honey on 16/5/5.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON

struct OriginalComment {
    var commentID               = 0
    var createdBy               = 0
    var commentStauts           = 0
    var createdUserName         = ""
    
    var imageURLSecondary       = ImageURL()
    var imageURLMain            = ImageURL()
    var content                 = Content()
    
    init (json: JSON) {
        
        self.commentID = json["comment_id"].intValue
        self.createdBy = json["created_by"].intValue
        
        self.content.v = json["content"]["v"].intValue
        self.content.text = json["content"]["text"].stringValue
        self.createdUserName = json["created_username"].stringValue
        self.commentStauts = json["comment_status"].intValue

        
        self.imageURLMain.v = json["image_url_main"]["v"].intValue
        for p in json["image_url_main"]["pics"].arrayValue {
            self.imageURLMain.pics.append(p.stringValue)
        }
        
        self.imageURLSecondary.v = json["image_url_secondary"]["v"].intValue
        for p in json["image_url_secondary"]["pics"].arrayValue {
            self.imageURLMain.pics.append(p.stringValue)
        }
        
        
    }
}

struct Comment {
    
    var commentID               = 0
    var createAt                = 0
    var createdBy               = 0
    var voteCount               = 0
    var relpyToComment          = 0
    
    var votedUp                 = false
    var isReplyToSomeComment    = false
    
    var imageURLMain            = ImageURL()
    var imageURLSecondary       = ImageURL()
    
    var content                 = Content()
    var userInfo                = UserInfo()
    
    var originalCommentInfo:OriginalComment?

    init (json: JSON) {
        
        self.userInfo.nickName = json["user_info"]["nick_name"].stringValue
        self.userInfo.headPic = json["user_info"]["head_pic"].stringValue
        self.userInfo.headPicSRC = json["user_info"]["head_pic_src"].stringValue
        
        
        
        self.imageURLMain.v = json["image_url_main"]["v"].intValue
        for p in json["image_url_main"]["pics"].arrayValue {
            self.imageURLMain.pics.append(p.stringValue)
        }
        
        self.imageURLSecondary.v = json["image_url_secondary"]["v"].intValue
        for p in json["image_url_secondary"]["pics"].arrayValue {
            self.imageURLMain.pics.append(p.stringValue)
        }
        
        self.commentID = json["comment_id"].intValue
        self.createdBy = json["created_by"].intValue
        self.createAt = json["created_at"].intValue
        self.relpyToComment = json["relpyToComment"].intValue
        self.voteCount = json["vote_count"].intValue
        
        self.votedUp = json["voted_up"].boolValue
        
        
        self.content.v = json["content"]["v"].intValue
        self.content.text = json["content"]["text"].stringValue
        
        self.isReplyToSomeComment = json["is_reply_to_some_comment"].boolValue
        

        if self.isReplyToSomeComment {
            let x = json["original_comment_info"]
            self.originalCommentInfo = OriginalComment(json: x)
        }
    }
    
    
    var pub_time_d :String {
        get {
            
            var ret = ""
            
            let cal = NSCalendar.currentCalendar()
            let pubtime = NSDate(timeIntervalSince1970: Double(self.createAt))
            let now = NSDate()
            
         
            let com = cal.components([.Day,  .Hour], fromDate: pubtime, toDate: now, options: .WrapComponents)
//             [cal components:unitFlags fromDate:date1 toDate:date2 options:0];
            
            if com.day == 0 {
                ret = "\(com.hour)小时前"
            }
            else
            {
                ret = "\(com.day)天前"
            }
            
            
            return ret
        }
    }
    
}

struct Content {
    var v = 0
    var text = ""
}

struct UserInfo {
    var nickName = ""
    var headPic  = ""
    var headPicSRC = ""
}

struct ImageURL {
    var v = 0
    var pics = [String]()
}

