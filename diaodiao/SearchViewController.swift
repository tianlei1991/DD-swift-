//
//  SearchViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/9.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBackgroundView: UIView!
    
    @IBOutlet weak var webView: UIWebView!
    
    
    var key:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSearchTextField()
        
        if let k = self.key {
            
            self.loadRequest(k)
            
            self.searchTextField.text = k
        }
    }
    
    //MARK: - 加载网页请求
    func loadRequest(key:String) {
        
        let api = Interfaces.kSearch(key).api().stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        if let api = api {
            let request = NSURLRequest(URL: NSURL(string: api)!)
            self.webView.loadRequest(request)
        }

    }
    
    //MARK: - 返回按钮
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

//MARK: - extension
typealias CustomeSearchBar = SearchViewController
extension CustomeSearchBar: UITextFieldDelegate {
    func setupSearchTextField() {
        let leftImage = UIImageView(image: UIImage(named: "searchIcon")!)
        leftImage.frame = CGRectMake(0, 0, 16, 16)
        let line = UIView(frame:CGRectMake(23, -3, 1, 20))
        line.backgroundColor = UIColor.redColor()
        let leftView = UIView(frame: CGRectMake(0, 0, 34, 16))
        
        leftView.addSubview(leftImage)
        leftView.addSubview(line)
        
        self.searchTextField.leftView = leftView
        self.searchTextField.leftViewMode = .Always
        self.searchTextField.clearButtonMode = .WhileEditing
        
        
        //修改placeholder的文字颜色
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "找到最值得买的好东西", attributes: [NSForegroundColorAttributeName:UIColor.redColor(), NSFontAttributeName:UIFont.systemFontOfSize(12)])
        
        self.searchBackgroundView.layer.cornerRadius = 20
        self.searchBackgroundView.layer.masksToBounds = true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let k = textField.text!
        
        self.loadRequest(k)
        
        textField.resignFirstResponder()
        
        return true
    }
}
