//
//  ZDMViewController.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit



class ZDMListViewController: ZDMBaseViewController {
    
   
    @IBOutlet weak var tableView: UITableView!

    
    private var selectedIndex:NSIndexPath? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.requestData { 
            self.tableView.reloadData()
        }
        
    }
  
    
    //MARK: - 跳转之前做的事情
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dst = segue.destinationViewController as! DetailViewController

        if let index = self.selectedIndex {
            
            let model = self.items?[self.feed_list![index.row]]
            
            dst.buyLink = model?.buylink
        }
    }
}



//MARK: - extension
typealias ZDMListTableViewDelegate = ZDMListViewController
extension ZDMListTableViewDelegate: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard super.feed_list != nil else {
            return 0
        }
        
        return super.feed_list!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ZDMListCell
        
        let m = super.items?[self.feed_list![indexPath.row]]!
        
        cell.configureCell(m!)
        
        print("\(m!.summary)")
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
//        if self.selectedIndex == nil {
//            return 100
//        }
        
        if indexPath.row == self.selectedIndex?.row {
            return 200
        }
        
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.selectedIndex?.row == indexPath.row {
            
            self.selectedIndex = nil
        }
        else
        {
            
            self.selectedIndex = indexPath
        }
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        //        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}



