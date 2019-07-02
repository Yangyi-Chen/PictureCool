//
//  MainTableViewCell.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/2.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    lazy var pictureView = { () -> UIImageView in
        let temp = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/9, y: 10, width: UIScreen.main.bounds.width/9*8, height: 150))
        temp.layer.cornerRadius = 17
        temp.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner,CACornerMask.layerMinXMaxYCorner]
        temp.contentMode = .scaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = nil
        pictureView.image = UIImage(named: "temp")
        self.addSubview(pictureView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
