//
//  ViewController.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class DDViewController: DDBaseViewController {
    
    let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
    let screenHeight = CGRectGetHeight(UIScreen.mainScreen().bounds)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headView: DDHeadView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBackgroundView: UIView!
    @IBOutlet weak var searchTextFieldTrailing: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchHotKeyView: UIView!
    
    @IBOutlet weak var searchBackgroundViewTrailing: NSLayoutConstraint!
    
    var items:Dictionary<String, ItemInfo>? = nil
    var tools:[Tool]?                       = nil  //顶部工具栏内容
    var carousels:[ItemInfo]?               = nil  //顶部滚动视图的内容
    var order_list:[String]?                = nil  //保存了items内的顺序编号,cid
    
    var currentSelectIndex:NSIndexPath?
    //用在headView上的链接
    var toolURL:String?
    ////用在headView上的链接，相当于currentSelectIndex选中后传递的内容
    var itemURL:String?
    //搜索时候使用的关键字,会在顶部的工具条里使用到
    var keyWord:String?
    
    var lastPostion:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        self.requestHomePage()
        self.setupSearchTextField()
     
    }
    
    //MARK: - 点击跳转详情
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
        
            let dst = segue.destinationViewController as! DetailViewController
            
            if let indexPath = self.currentSelectIndex {
                
                if let t = self.items {
                    if let o = self.order_list{
                        let model = t[o[indexPath.section]]
                        dst.ddURL = model!.url
                    }
                }
                
            }
            else if let tookLink = self.toolURL {
                dst.ddToolURL = tookLink
            }
            else if let itemLink = self.itemURL {
                
                dst.ddURL = itemLink
            }
            
        }
        else if segue.identifier == "searchSegue" {
            
            let dst = segue.destinationViewController as! SearchViewController
            
            dst.key = self.keyWord
        }
        
        self.keyWord = nil
        self.itemURL = nil
        self.toolURL = nil
        self.currentSelectIndex = nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.hideSearchView()
    }
    
  
    func requestHomePage() {
        
        CommonDataOperationE.network {
            let result = $0 /*参数的另外一种写法*/ as! Dictionary<String, Any>
            
            let order = result[DDResultKey.DD_ORDER_LIST.rawValue] as! Array<String>
            let item  = result[DDResultKey.DD_ITEMS.rawValue] as! Dictionary<String, ItemInfo>
            let tool  = result[DDResultKey.DD_TOOL.rawValue] as! Array<Tool>
            let carousel = result[DDResultKey.DD_CAROUSELS.rawValue] as! Array<ItemInfo>
            self.order_list = order
            self.items      = item
            self.tools      = tool
            self.carousels  = carousel
            
            //用来处理顶部工具条的点击事件
            self.headView.toolClick = { (tool) in
                
                print(tool.type)
                
                if tool.type == "link" {
                    self.toolURL = tool.val //设置要跳转的链接
                    self.performSegueWithIdentifier("showDetailSegue", sender: nil)
                }
                else if tool.type == "search" {
                    
                    self.keyWord = tool.val
                    self.performSegueWithIdentifier("searchSegue", sender: nil)
                }
                
            }
            //处理顶部滚动图片的点击事件
            self.headView.itemClick = { (item) in
                self.itemURL = item.url
                print(item.url)
                self.performSegueWithIdentifier("showDetailSegue", sender: nil)
            }
            
            if let t = self.tools {
                
                self.headView.setHeadViewCollectionDataSource(t)
            }
            
            self.headView.setHeadViewScrollViewBannerDataSource(self.carousels!)
            self.tableView.reloadData()
        }.fetchRequestWith(DDDataOperation())
    }
 
}

//MARK: - 文本框代理
typealias DDTextFieldDelegate = DDViewController
extension DDTextFieldDelegate: UITextFieldDelegate {
    //MARK: - 点击搜索框时候出现的动画
    func textFieldDidBeginEditing(textField: UITextField) {
        self.showSearchView()
    }
    
    //MARK: - 回车处理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.keyWord = self.searchTextField.text
        self.performSegueWithIdentifier("searchSegue", sender: nil)
        
        self.searchTextField.text = nil
        
        return true
    }
}

//MARK: - 滚动代理
typealias DDScrollDelegate = DDViewController
extension DDScrollDelegate : UIScrollViewDelegate {
    //MARK: - 滚动时候隐藏或者显示搜索框
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            
            let currentPostion = scrollView.contentOffset.y
            var constant:CGFloat = 0.0
            
            if currentPostion - self.lastPostion > 20 {
                if self.searchBackgroundViewTrailing.constant == 8 {
                    constant = self.searchBackgroundView.frame.size.width - 18 /*文本框的距离左侧的约束大小*/ - 16 /*放大镜大小*/
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.searchBackgroundViewTrailing.constant = constant
                        self.view.layoutIfNeeded()
                    })
                    
                }
                
            }
            else if self.lastPostion - currentPostion > 20 {
                if self.searchBackgroundViewTrailing.constant != 8 {
                    constant = 8
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.searchBackgroundViewTrailing.constant = constant
                        self.view.layoutIfNeeded()
                    })
                }
            }
            
            
            self.lastPostion = currentPostion
        }
    }
}

//MARK: - 搜索
typealias DDSearch = DDViewController
extension DDSearch {
    
    //MARK: - 点击热门搜索
    @IBAction func hot(sender: UIButton) {
        
        let title = sender.titleForState(.Normal)
        
        self.keyWord = title
        
        self.performSegueWithIdentifier("searchSegue", sender: nil)
    }
    
    @IBAction func cancelAction(sender: UIButton) {
        
        self.hideSearchView()
        
    }
    
    //MARK: - 定制搜索
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showSearch))
        
        self.searchBackgroundView.addGestureRecognizer(tap)
        
    }
    
    //MARK: - 显示搜索界面
    func showSearch() {
        
        self.searchTextField.becomeFirstResponder()
        self.showSearchView()
        
    }
    
    func showSearchView() {
        UIView.animateWithDuration(0.2) {
            
            self.cancelButton.hidden = false
            self.searchHotKeyView.hidden = false
            self.searchBackgroundViewTrailing.constant = 50
            
            self.view.layoutIfNeeded()
            
        }
    }
    
    func hideSearchView() {
        
        UIView.animateWithDuration(0.3) {
            
            self.cancelButton.hidden = true
            self.searchHotKeyView.hidden = true
            self.searchBackgroundViewTrailing.constant = 8
            
            self.searchTextField.resignFirstResponder()
            
            self.view.layoutIfNeeded()
            
        }
    }
    
}

//MARK: - tableView代理
typealias DDViewControllerTableViewDelegate = DDViewController
extension DDViewControllerTableViewDelegate : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.currentSelectIndex = indexPath
        
        self.performSegueWithIdentifier("showDetailSegue", sender: nil)
    }
}
//MARK: - 数据源代理
typealias DDViewControllerTableViewDataSource = DDViewController
extension DDViewControllerTableViewDataSource: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if let x = self.order_list {
            return x.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model:ItemInfo = self.items![self.order_list![indexPath.section]]!
        
        //type4,3,2使用相同的cell, 1为单独的cell
        var cell:UITableViewCell
        
        switch model.ctype {
        case 1:
            let type1 = tableView.dequeueReusableCellWithIdentifier("type1") as! CellType1
            type1.configureCell(model)
            cell = type1
            
        default:
            let type4 = tableView.dequeueReusableCellWithIdentifier("type4") as! CellType4
            type4.configureCell(model)
            cell = type4
        }
        
        
        
        return cell
        
    }
}