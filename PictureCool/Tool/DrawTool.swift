//
//  DrawTool.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/3.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class DrawTool: NSObject {
    class func drawIn(imageView:UIImageView) -> UIImage{
        let size = imageView.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        imageView.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.layer.contents = nil
        return image!
    }
}
