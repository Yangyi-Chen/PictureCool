//
//  BasicScrollView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class BasicScrollView:UIScrollView,UIGestureRecognizerDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.contentOffset = CGPoint(x: self.frame.width, y: self.contentOffset.y)
        self.contentSize = CGSize(width: self.frame.width*2, height:0)
        self.bounces = false 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer.state != .failed) {
            return true;
        } else {
            return false;
        }
    }
}
