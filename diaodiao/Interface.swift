//
//  Interface.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation


enum Interfaces {
    case kHome, kZDM, kComment, kDiscoveryList(String), kDiscoveryItem, kSearch(String)
    
    
    func api() -> String {
        
        var apiString = ""
        
        switch self {
        case .kHome:
            apiString = "http://api.diaox2.com/v4/meta"
        case .kZDM:
            apiString = "http://api.diaox2.com/v3/zdm"
        case .kComment:
            apiString = "http://api.diaox2.com/v1/comment"
        case .kDiscoveryList(let id):
            apiString = "http://c.diaox2.com/view/app/?m=tag&tid=" + id
        case .kDiscoveryItem:
            apiString = "http://api.diaox2.com/v2/url/meta_and_stat"
        case .kSearch(let key):
            apiString = "http://t.diaox2.com/view/app/search.php?query=" + key
        }
        
        return apiString
    }
    
}



struct Interface {
    
    static let homePage = "http://api.diaox2.com/v4/meta" //post
    
    static let zdm = "http://api.diaox2.com/v3/zdm"
    
    //评论内容
    /*
     {
     "action": "get_comment_of_article",
     "article_id": 25649544697684, //帖子id
     "count": 2, //评论数
     "start": 0,
     "with_top_comment": 1
     }
    */
    static let comment = "http://api.diaox2.com/v1/comment" //post
    
    static let discoveryList = "http://c.diaox2.com/view/app/?m=tag&tid="
    
    //点击详情的时候获取商品的信息
    //需提交商品的连接：show
    static let discoveryItem = "http://api.diaox2.com/v2/url/meta_and_stat" //post
    
    //搜索
    static let search = "http://t.diaox2.com/view/app/search.php?query=" //Get,query为查询的关键字
    
}






