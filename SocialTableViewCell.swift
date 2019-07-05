//
//  SocialTableViewCell.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {
    lazy var pictureView = { () -> UIImageView in
        let temp = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/10, y: 10, width: UIScreen.main.bounds.width/10*8, height: 150))
        temp.layer.cornerRadius = 17
//        temp.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner,CACornerMask.layerMinXMaxYCorner]
        temp.contentMode = .scaleAspectFit
        temp.clipsToBounds = true
        return temp
    }()
    lazy var headView = { () -> UIImageView in
        let temp = UIImageView(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
        temp.layer.cornerRadius = 25
        //        temp.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner,CACornerMask.layerMinXMaxYCorner]
        temp.contentMode = .scaleAspectFill
        temp.clipsToBounds = true
        temp.layer.borderColor = UIColor.tintDark.cgColor
        temp.layer.borderWidth = 8
        return temp
    }()
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = nil
        //pictureView.image = UIImage(named: "temp")
        self.addSubview(pictureView)
        headView.image = UIImage(named: "headT")
        self.pictureView.addSubview(headView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
