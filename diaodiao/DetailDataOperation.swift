//
//  DetailDataOperation.swift
//  diaodiao
//
//  Created by honey on 16/5/27.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DetailDataOperation {
    
}

struct DetailCommentDataOperation {
}

extension DetailDataOperation: CommonDataOperation {

    func findAllWithNetwork(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
        
        
        let api = Interfaces.kDiscoveryItem.api()
        
        NetworkHelper.request(requestURL: api, parameters: parameters) { (value, error) in
            
            
            guard error == nil else {
                return
            }
            
            let json = JSON(value!)
            
            let meta = json["res"][0]["meta"]
            let status = json["res"][0]["status"]
            let webToolItem = ZDM(json: meta)
            let webToolItemStatus = Status(json: status)
            
            
            let x:[String:Any] = ["webToolItem":webToolItem, "webToolItemStatus":webToolItemStatus]
            
            result(x)
        
        }
        
    }
    
    func findAllWithDatabase(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
    }
    
    func findAllWithOtherWay(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
    }
    
}

extension DetailCommentDataOperation: CommonDataOperation {
    
    func findAllWithNetwork(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
        
        let api = Interfaces.kComment.api()
        
        NetworkHelper.request(requestURL: api, parameters: parameters) { (value, error) in
            
            
            let json = JSON(value!)
            
            let comm = json["res"]["comments"]
            
            var comments = [Comment]()
            
            for c in comm.arrayValue {
                
                let com = Comment(json: c)
                
                comments.append(com)
                
            }
            
            result(comments)
            
        }
        

    }
    
    func findAllWithDatabase(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
        
    }
    
    func findAllWithOtherWay(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
        
    }
}

