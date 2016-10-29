//
//  MeViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/9.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSourceIcon = [ ["settings_photo"],
                           ["favor", "message"],
                           ["settings"],
                           ["suggest", "score", "recomend", "about"] ]
    
    var dataSourceTitle = [ ["点击登录"],
                            ["我的收藏", "消息"],
                            ["设置"],
                            ["调调小秘书", "App Store评分", "推荐调调给朋友", "关于调调"] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的"

        self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        
        
    }
    
    

}


typealias MeTabelViewDataSource = MeViewController
extension MeTabelViewDataSource: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSourceIcon.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arr = self.dataSourceIcon[section]
        
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        cell.textLabel?.text = self.dataSourceTitle[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: self.dataSourceIcon[indexPath.section][indexPath.row])
        
        
        return cell
    }
}


typealias MeTabelViewDelegate = MeViewController
extension MeTabelViewDelegate: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 70
            
        }
        return 40
        
    }
}
