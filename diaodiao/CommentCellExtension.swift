//
//  CommentCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/5/6.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation

extension CommentCell {
    
    func configureCell(model:Comment) {
        
        self.headIconImageView.sd_setImageWithURL(NSURL(string: model.userInfo.headPic))
        
        self.nickNameLabel.text = model.userInfo.nickName
        
        self.voteUpLabel.text = String(model.voteCount)
        self.replayCommentLabel.text = model.content.text
        
        if model.isReplyToSomeComment {
            self.orignCommentLabel.text = "  " + model.originalCommentInfo!.createdUserName + " " + model.originalCommentInfo!.content.text
            self.orignCommentLabel.hidden = false
//            self.replayCommentYConstraint.constant = self.orginCommentYConstraint.constant
            
            self.replayCommentYConstraint.constant = 8
        }
        else
        {
            self.orignCommentLabel.text = nil
            self.orignCommentLabel.hidden = true
            self.replayCommentYConstraint.constant = -3
        }
        
        
        
        
        
        self.fromTimeLabel.text = model.pub_time_d

    }
}