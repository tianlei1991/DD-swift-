//
//  CommentCell.swift
//  diaodiao
//
//  Created by honey on 16/5/6.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var headIconImageView: UIImageView!

    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var voteUpLabel: UILabel!
    
    @IBOutlet weak var orignCommentLabel: UILabel!
    
    @IBOutlet weak var replayCommentLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    
    @IBOutlet weak var replayCommentYConstraint: NSLayoutConstraint!
    @IBOutlet weak var orginCommentYConstraint: NSLayoutConstraint!
    
    var rawYConstraintConstant:CGFloat = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func moreAction(sender: UIButton) {
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
