//
//  UI.swift
//  diaodiao
//
//  Created by honey on 16/7/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation


struct Widget {
    
    typealias UIButtonAction = Action
    
    //如果是autolayout,则将控件的frame设置为0
    static var autoLayout:Bool = false
    
    static func create(labelInRect rect:CGRect,
                                   text:String? = nil,
                                   numberOfLines:Int = 1,
                                   textAlignment:NSTextAlignment = .Left,
                                   _ config:((UILabel) -> Void)?) {
        
        let label = UILabel()
        
        if !autoLayout {
            label.frame = rect
        }
        
        label.text = text
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        
        if let config = config {
            config(label)
        }
    }
    
    static func create(buttonInRect rect:CGRect,
                                    type:UIButtonType,
                                    norTitle:String = "", norImage:UIImage? = nil,
                                    pressTitle:String = "", pressImage:UIImage? = nil,
                                    actions:[UIButtonAction]? = nil,
                                    _ config:((UIButton) -> Void)?) {
        
        let button = UIButton(type: type)
        
        if !autoLayout {
            button.frame = rect
        }
        
        button.setTitle(norTitle,   forState: .Normal)
        button.setImage(norImage,   forState: .Normal)
        
        button.setTitle(pressTitle, forState: .Highlighted)
        button.setImage(pressImage, forState: .Highlighted)
        

        
        if let actions = actions {
            
            for action in actions {
                
                button.addTarget(action.target, action: action.action, forControlEvents: action.event)
                
            }
            
        }
        
        
        if let config = config {
            config(button)
        }
    }
    
    
    static func create(textFieldInRect rect:CGRect,
                                       style:UITextBorderStyle = .RoundedRect,
                                       defaultText:String? = nil,
                                       placeholder:String? = nil,
                                       textAlignment:NSTextAlignment = .Left,
                                       _ config:((UITextField) -> Void)?) {
        
        
        let textField = UITextField()
        
        if !autoLayout {
            textField.frame = rect
        }
        
        textField.text = defaultText
        textField.placeholder = placeholder
        textField.textAlignment = textAlignment
        
        if let config = config {
            config(textField)
        }
    }
    
    struct Action {
        
        var target:AnyObject?
        var action:Selector
        var event:UIControlEvents
        
        init(target:AnyObject?, action:Selector, event:UIControlEvents) {
            self.target = target
            self.action = action
            self.event = event
        }
    }

}









