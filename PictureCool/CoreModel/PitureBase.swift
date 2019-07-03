//
//  PitureBase.swift
//  baiduAI
//
//  Created by 无敌帅的yyyyy on 2019/7/2.
//  Copyright © 2019 CoolYYY. All rights reserved.
//

import Foundation
class PictureBase{
    
    let arr1 = ["山峦","云雾","瀑布","江河"]
    let arr2 = ["河马","水牛"]
    let arr3 = ["餐饮场所","方便面"]
    let arr4 = ["卡通动漫人物"]
    let arr5 = ["嫩芽","新芽"]
    lazy var PictureDic:Dictionary<String,Array<String>>  =  [
        "shanshui":arr1,
        "dongwu":arr2,
        "shiwu":arr3,
        "renwu":arr4,
        "zhiwu":arr5
        ]
    
    
    
    func match(matchString:String)->String{
        for (key,arr)  in PictureDic{
            for str in arr{
                if str == matchString{
                    return key
                }
            }
        }
        return ""
    }
    
    
    
    
    
    
    
}
