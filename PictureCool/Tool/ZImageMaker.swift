//
//  ZImageMaker.swift
//  PictureCool
//
//  Created by lighayes on 2019/6/30.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
extension UIImage {
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }
}
class ZImageMaker {
    static func makeAddImage()->UIImage{
        var add = UIImage(named: "add_new")?.reSizeImage(reSize: CGSize(width: 70, height: 70))
        add = add?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return add!
    }
    static func makeCameraImage()->UIImage{
        var add = UIImage(named: "camera-1")?.reSizeImage(reSize: CGSize(width: 20, height: 20))
        add = add?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return add!
    }
    static func makePhotoBookImage()->UIImage{
        var add = UIImage(named: "photobook-1")?.reSizeImage(reSize: CGSize(width: 20, height: 20))
        add = add?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return add!
    }
    static func bigCameraImage()->UIImage{
        var add = UIImage(named: "camera-1")?.reSizeImage(reSize: CGSize(width: 70, height: 70))
        add = add?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return add!
    }
    static func bigPhotoBookImage()->UIImage{
        var add = UIImage(named: "photobook-1")?.reSizeImage(reSize: CGSize(width: 70, height: 70))
        add = add?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return add!
    }
    
}

