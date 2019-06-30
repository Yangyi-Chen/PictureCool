//
//  NewFile.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/6/29.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import UIKit
class PictureProcessCore{
    var image:UIImage?
    var saveProcessor:saveCore?
    
    
    
    //存图片
    func savePicture(image:UIImage, name:String){
        saveProcessor!.save(image: image, name: name)
    }
    
    //提取图片
    func getPicture(name:String)-> UIImage{
        return saveProcessor!.getPicture(name: name)
    }
    
    //获取图片中的主要元素
    func getTheMainElement(){
        
    }
    
    //获取图片中次要元素
    func getTheSecondElement(){
        
    }
    
    //获取诗词数组   "motto" 或 "scene"
    func getTheLines(_ type: String)->Array<String>{
        return returnLines(type)
    }
    
    
    
    
    
    
    
    
    
    init(_ image: UIImage){
        self.image = image
        saveProcessor = saveCore()
    }
    
    
    
    
    let sceneLines: Array<String> = ["绿树阴浓夏日长，楼台倒影入池塘。","碧玉妆成一树高，万条垂下绿丝绦","水晶帘动微风起，满架蔷薇一院香","几处早莺争暖树，谁家新燕啄春泥"]
    let mottoLines = ["一个人有生就有死，但只要你活着，就要以最好的方式活下去。","当我们失去的时候，才知道自己曾经拥有。","眼泪的存在，是为了证明悲伤不是一场幻觉。"]
    
    
    
    private func returnLines(_ type: String) -> Array<String>{
        switch type{
        case "motto":
            return mottoLines
        case "scene":
            return sceneLines
        default:
            return []
        }
    }
}

