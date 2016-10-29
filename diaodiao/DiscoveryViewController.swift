//
//  DiscoveryViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class DiscoveryViewController: DDBaseViewController { //UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, {
    
//    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBackgroundView: UIView!
    
    @IBOutlet weak var searchBackgroundViewTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchHotKeyView: UIView!
    
    var keyWord:String?
    
    
    var layout: [JSON]?

    var items:[Discovery]? = nil
    
    var currentSelectNode:Node?
    
    //当前选中的选项
    private var selectedIndex:NSIndexPath?
    
    
    var expendCells = [NSIndexPath]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readConfig()
        self.setupSearchTextField()
        
        self.tableView.sectionFooterHeight = 0.001
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.hideSearchView()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //searchSegue
        
        if segue.identifier == "showDetailSegue" {
            
            let destinationVC = segue.destinationViewController as! DetailViewController
            
            if let node = self.currentSelectNode {
                destinationVC.discoverURL = node.tid
            }
            
            destinationVC.hidesBottomBarWhenPushed = true
        }
        else if segue.identifier == "searchSegue" {
            
            let dst = segue.destinationViewController as! SearchViewController
            
            dst.key = self.keyWord
        }
        
       
    }
    
}

//MARK: - extension
typealias DiscoveryConfigRead = DiscoveryViewController
extension DiscoveryConfigRead {
    //解析配置文件
    func readConfig() {
        
        CommonDataOperationE.other {
        
            self.items = $0 as? Array<Discovery> ?? nil
            
            self.tableView.reloadData()
        
        }.fetchRequestWith(DiscoveryDataOperation())
    }
    
}


typealias DiscoverySearch = DiscoveryViewController
extension DiscoverySearch {
    func setupSearchTextField() {
        
        let leftImage = UIImageView(image: UIImage(named: "searchIcon")!)
        leftImage.frame = CGRectMake(1, -1, 16, 16)
        let line = UIView(frame:CGRectMake(23, -3, 1, 20))
        line.backgroundColor = UIColor.redColor()
        let leftView = UIView(frame: CGRectMake(0, 0, 34, 16))
        
        leftView.addSubview(leftImage)
        leftView.addSubview(line)
        
        self.searchTextField.leftView = leftView
        self.searchTextField.leftViewMode = .Always
        self.searchTextField.clearButtonMode = .Always
        
        //修改placeholder的文字颜色
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "找到最值得买的好东西", attributes: [NSForegroundColorAttributeName:UIColor.redColor(), NSFontAttributeName:UIFont.systemFontOfSize(12)])
        
        self.searchBackgroundView.layer.cornerRadius = 20
        self.searchBackgroundView.layer.masksToBounds = true
        
    }
    
    //点击热门搜索
    @IBAction func hot(sender: UIButton) {
        
        let title = sender.titleForState(.Normal)
        
        self.keyWord = title
        
        self.performSegueWithIdentifier("searchSegue", sender: nil)
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        
        self.hideSearchView()
        
    }
    
    func hideSearchView() {
        
        UIView.animateWithDuration(0.2) {
            
            self.cancelButton.hidden = true
            self.searchHotKeyView.hidden = true
            self.searchBackgroundViewTrailing.constant = 8
            
            self.searchTextField.resignFirstResponder()
            
            self.view.layoutIfNeeded()
            
        }
    }

}

typealias DiscoveryTextFieldDelegate = DiscoveryViewController
extension DiscoveryTextFieldDelegate: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        UIView.animateWithDuration(0.2) {
            
            self.cancelButton.hidden = false
            self.searchHotKeyView.hidden = false
            self.searchBackgroundViewTrailing.constant = 50
            
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.keyWord = self.searchTextField.text
        self.performSegueWithIdentifier("searchSegue", sender: nil)
        
        self.searchTextField.text = nil
        
        
        return true
    }
}


typealias DiscoveryTableViewDelegate = DiscoveryViewController
extension DiscoveryTableViewDelegate: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
//        另外一种折叠方法,使用tableview的beginUpdates方法
//        if expendCells.contains(indexPath) {
//            let item = self.items[indexPath.row]
//            
//            return CGFloat(item.rowHeight + 10 + 90/*顶部图片的高度*/)
//        }
        
        if indexPath.row == self.selectedIndex?.row {
            //手动计算
            let item = self.items?[indexPath.row]
            
            

            
            return CGFloat(item!.rowHeight + 10 + 90/*顶部图片的高度*/)
        }
        
        return 90 /*默认高度为90*/
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        另外一种折叠方法,使用tableview的beginUpdates方法
//        if expendCells.contains(indexPath) {
//            
//            let index = expendCells.indexOf(indexPath)
//            
//            expendCells.removeAtIndex(index!)
//
//        }
//        else {
//            
//            expendCells.append(indexPath)
//        }
//        
//        tableView.beginUpdates()
//        tableView.endUpdates()
        
        if self.selectedIndex?.row == indexPath.row {
            
            self.selectedIndex = nil
        }
        else
        {
            
            self.selectedIndex = indexPath
        }
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        //        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}



typealias DiscoveryTableViewDataSource = DiscoveryViewController
extension DiscoveryTableViewDataSource: UITableViewDataSource {
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.items.count
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if self.expand[section] {
//            return 1
//        }
        
        guard self.items != nil else {
            return 0
        }
        
        return self.items!.count//model.node.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! DiscoveryTableCell
        
        let model = self.items?[indexPath.row]
        
        cell.configureCell(model!)
        
        
        //处理item点击的内容
        cell.didCollectionViewItemSelected = { (node) in
            
            
            self.currentSelectNode = node
            
            self.performSegueWithIdentifier("showDetailSegue", sender: nil)
            
        }
        
        return cell
    }
}