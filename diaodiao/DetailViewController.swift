//
//  DiscoveryItemListViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/5.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    //底部的工具条,用来显示【赞,收藏,评论,立即购买】
    @IBOutlet weak var webTool: UIView!
    
    var bridge:WebViewJavascriptBridge!
    
    //用来设置webtool的显示,默认在屏幕底部之外,需要显示的时候上衣
    @IBOutlet weak var webToolViewBottomConstraint: NSLayoutConstraint!
    //用来设置webview和底部的距离,因为webtool工具条并不是一开始就显示,而是解析完数据后才会显示(有可能会不显示),所以需要重新更新该约束
    @IBOutlet weak var webViewBottomConstraint: NSLayoutConstraint!
    
    //用来设置底部webtool的按钮比例,
    //这里建立的2个约束关系,都是用来约束按钮和屏幕的比例
    //其中webToolControlMultiplier5的约束比例为 1 / 5(将屏幕分为5份,一个按钮占1份,其中立即购买占了2份)
    //webToolControlMultiplier3的约束比例为1 / 3
    @IBOutlet weak var webToolControlMultiplier5: NSLayoutConstraint!
    @IBOutlet weak var webToolControlMultiplier3: NSLayoutConstraint!
    
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var discoverURL:String? //发现
    var ddURL:String? //调调
    var ddToolURL:String? //调调顶部的item
    var buyLink:String?//普通item的URL
    
    
    //底部webTool内容
    var webToolItem:ZDM?
    //底部webtool上的按钮内容【赞,收藏,评论,立即购买】
    var webToolItemStatus:Status?
    
    //当前的帖子id,用来显示评论
    var content_id:Int?
    
    //是否显示底部工具条
    var isShow = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNav()
        
        self.setupBridge()
        
        self.loadRequest()
   
    }
    

    
    //MARK: - 导航条
    func setupNav() {
        
        let leftImage = UIImage(named: "IconBack")
        let button = UIButton(type: .Custom)
        button.setBackgroundImage(leftImage, forState: .Normal)
        button.frame = CGRectMake(0, 0, leftImage!.size.width, leftImage!.size.height)
        button.addTarget(self, action: #selector(gooback), forControlEvents: .TouchUpInside)
        let leftItem = UIBarButtonItem(customView: button)
        
        
        self.title = "调调"
        
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dst = segue.destinationViewController as! DetailCommentViewController
        
        dst.content_id = self.content_id
    }
    
    
    //MARK: - WebView操作
    func loadRequest() {
        var request:NSURLRequest!
        
        if let link = self.discoverURL {
            request = NSURLRequest(URL: NSURL(string: Interface.discoveryList + link)!)
        }
        else if let linkDD = self.ddURL {
            
            request = NSURLRequest(URL: NSURL(string: linkDD)!)
        }
        else if let linkDDTool = self.ddToolURL {
            
            request = NSURLRequest(URL: NSURL(string: linkDDTool)!)
        }
        else if let buy = self.buyLink {
            
            request = NSURLRequest(URL: NSURL(string: buy)!)
        }
        
        
        self.webView.loadRequest(request)
    }
    
    func gooback()  {
        
        if self.webView.canGoBack
        {
            self.hideToolBar()
            self.webView.goBack()
        }
        else if buyLink != nil
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            self.navigationController?.popViewControllerAnimated(true)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}

//MARK: - extension
typealias DetailWebViewDelegate = DetailViewController
extension DetailWebViewDelegate: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        self.isShow = false
        
        let string = request.URL!.absoluteString
        if string.containsString("show") || string.containsString("zk") {
            
            self.isShow = true
            let p = ["urls":[["url":string]]]
            
            
            CommonDataOperationE.network({
                
                let result = $0 as! Dictionary<String, Any>
                
                self.webToolItem = result["webToolItem"] as? ZDM
                self.webToolItemStatus = result["webToolItemStatus"] as? Status
                
                if let item = self.webToolItem {
                    
                    if !item.has_buylink {
                        
                        //用来设置底部webtool的按钮比例,
                        //这里建立的2个约束关系,都是用来约束按钮和屏幕的比例
                        //其中webToolControlMultiplier5的约束比例为 1 / 5(将屏幕分为5份,一个按钮占1份,其中立即购买占了2份)
                        //webToolControlMultiplier3的约束比例为1 / 3
                        self.webToolControlMultiplier5.active = false
                        self.webToolControlMultiplier3.active = true
                    }
                }
                
            }).fetchRequestWith(DetailDataOperation(), p)
        }
        return true
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        if self.isShow && self.webToolItemStatus != nil {
            
            self.bridge.callHandler("updatePageView")
            
            self.upLabel.text       = "赞 " +   String(self.webToolItemStatus!.up)
            self.favLabel.text      = "收藏 " + String(self.webToolItemStatus!.fav)
            self.commentLabel.text  = "评论 " + String(self.webToolItemStatus!.comment)
            
            self.showToolBar()
        }
    }
}

//MARK: - oc和js的桥接代码
typealias DetailWebViewBridge = DetailViewController
extension DetailWebViewBridge {
    
    func setupBridge() {
        //WebViewJavascriptBridge.enableLogging()
        
        self.bridge = WebViewJavascriptBridge(forWebView: self.webView, webViewDelegate: self, handler: { (data, callback) in
        })
        
        
        //显示底部评论内容,需要通过callback给页面回传app_name, version号
        self.bridge.registerHandler("getAppEnv") { (data, callback) in
            //print("getAppEnv ---> \(data) <----")
            callback(["app_name":"diaodiao", "version":"3.1"])
        }
        
        
        //设置赞的颜色
//        self.bridge.registerHandler("clientKVGet") { (data, callback) in
//            
//            //print("clientKVGet:---> \(data) <----")
//            
//            //callback("无感|赞")
//        }
        
        self.bridge.registerHandler("showComment") { (data, callback) in
            print("showComment ----> \(data) <----")
            
            callback("YES")
            
            let dit = data as! NSDictionary
            //
            //print("\(dit.allKeys)00000<-----")
            
            let contentString = dit["content_id"] as! NSString
            self.content_id = contentString.integerValue
            //
            self.performSegueWithIdentifier("commentSegue", sender: nil)
        }
        
        //图片浏览
        self.bridge.registerHandler("enter_pic_browser") { (data, callback) in
            
            print("enter_pic_browser ----> \(data) <----")
        }
    }
}

typealias DetailToolAction = DetailViewController
extension DetailToolAction {
    
    //隐藏底部工具条
    func hideToolBar() {
        if self.webToolItemStatus != nil {
            UIView.animateWithDuration(0.3, animations: {
                
                self.webToolViewBottomConstraint.constant = -45
                self.webViewBottomConstraint.constant -= 45
                
                self.view.layoutIfNeeded();
            })
        }
    }
    
    //显示底部工具条
    func showToolBar() {
        UIView.animateWithDuration(0.5, animations: {
            
            self.webToolViewBottomConstraint.constant = 0
            self.webViewBottomConstraint.constant += 45
            
            self.view.layoutIfNeeded()
        })
    }
    
    //赞
    @IBAction func voteUp(sender: UIControl) {
        
    }
    //收藏
    @IBAction func favAction(sender: UIControl) {
        
    }
    //进入评论
    @IBAction func commentAction(sender: UIControl) {
        
        if let item = self.webToolItem {
            
            self.content_id = Int(item.cid)
            
            self.performSegueWithIdentifier("commentSegue", sender: nil)
            
        }
        
    }
    
    //立即购买
    @IBAction func buyNow(sender: UIButton) {
        
        if let item = self.webToolItem {
            let url = NSURL(string: item.buylink)
            
            let request = NSURLRequest(URL: url!)
            
            webView.loadRequest(request)
            
            self.hideToolBar()
        }
        
    }
}


