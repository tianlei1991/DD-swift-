//
//  NetWorkHelper.swift
//  diaodiao
//
//  Created by honey on 16/5/20.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import Alamofire

public enum RequestMethod:String {
    case GET, POST1/*表单*/, POST2/*文件上传*/
}

public enum Encoding {
    case URL
    case JSON
}

public typealias Result = (value:AnyObject?, error:NSError?)->Void


struct NetworkHelper {
    
    static func request (method:RequestMethod = .POST1,
                         requestURL url:String,
                         parameters:Dictionary<String, AnyObject>?,
                         encode:Encoding = .JSON,
                         callback:Result) ->Void {
                
        var enc:ParameterEncoding
        
        switch encode {
        case .URL:
            enc = ParameterEncoding.URL
            
        case .JSON:
            enc = ParameterEncoding.JSON
        }
        
        switch method {
        case .GET:
            NetworkHelper().get(url, parameters: parameters, encode: enc, callback: callback)
        case .POST1:
            NetworkHelper().post(url, parameters: parameters, encode: enc, callback: callback)
        case .POST2:
            NetworkHelper().uploadfile()
        
        }
    }
    
    
   private func get(url:String,
                    parameters:Dictionary<String, AnyObject>?,
                    encode:ParameterEncoding = .JSON,
                    callback:Result) -> Void {
    
         Alamofire.request(.GET, url, parameters: parameters, encoding: encode).responseJSON { (response) in
            callback(value: response.result.value, error: response.result.error)
        }
    }
    
    
    private func post(url:String,
                      parameters:Dictionary<String, AnyObject>?,
                      encode:ParameterEncoding = .JSON,
                      callback:Result) -> Void {
    
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: encode).responseJSON { (response) in
            callback(value: response.result.value, error: response.result.error)
        }
    }
    
    private func uploadfile() -> Void {
        
    }
}
