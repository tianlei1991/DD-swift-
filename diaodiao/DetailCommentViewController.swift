//
//  DiscoveryCommentViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/6.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


///// 需要当地抽取出来,和首页共用
class DetailCommentViewController: UIViewController {
    
    
    var content_id:Int?
    var comments:[Comment]? = nil

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftImage = UIImage(named: "IconBack")
        let button = UIButton(type: .Custom)
        button.setBackgroundImage(leftImage, forState: .Normal)
        button.frame = CGRectMake(0, 0, leftImage!.size.width, leftImage!.size.height)
        button.addTarget(self, action: #selector(gooback), forControlEvents: .TouchUpInside)
        let leftItem = UIBarButtonItem(customView: button)
        
        
        self.title = "评论"
        
        self.navigationItem.leftBarButtonItem = leftItem


        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view.
        
        self.requestComment()
        
    }
    
    func gooback()  {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: - 请求评论
    func requestComment() {
        
        let dict:[String:AnyObject] = [
                                        "article_id": self.content_id!,
                                        "action": "get_comment_of_article",
                                        "with_top_comment": 1,
                                        "uid": 0,
                                        "start": 0
                                      ]

        
        CommonDataOperationE.network {
            
            self.comments = $0 as? Array<Comment>
            
            self.tableView.reloadData()
        
        }.fetchRequestWith(DetailCommentDataOperation(), dict)
        
            
    }
}

typealias CommentTableViewDataSource = DetailCommentViewController
extension CommentTableViewDataSource: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard self.comments != nil else {
            return 0
        }
        
        
        return self.comments!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CommentCell
        
        
        let model = self.comments?[indexPath.row]
        
        cell.configureCell(model!)
        
        
        return cell
    }
}
