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
   
    var saveProcessor:saveCore?
    var tag:String?
    
    var theTotalNumberofPicture:Int?
    
    let linesbase:lineBase?
    
    
    
    
    
    //存图片
    func savePicture(image:UIImage){
        saveProcessor!.save(image: image, nameNumber: String(theTotalNumberofPicture!))
        theTotalNumberofPicture = theTotalNumberofPicture! + 1
    }
    
    //提取图片
    func getPicture(nameNumber:String)-> UIImage{
        return saveProcessor!.getPicture(nameNumber: nameNumber)
    }
    
    
    
    //提取所有图片
    func getAllPicture()->Array<UIImage>{
        var array = Array<UIImage>()
        var i = 0
        while(i<theTotalNumberofPicture!){
            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(String(i))
            let data = try! Data(contentsOf: fileURL)
            let image = UIImage(data: data)
            array.append(image!)
            i = i+1
        }
        return array
    }
    
    //删除指定编号的的图片
    func deletePicture(nameNumber:String){
        var oldNameNumber = (Int(nameNumber))!
        var i = (Int(nameNumber))!+1
        while(i<theTotalNumberofPicture!){
            let oldURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(String(oldNameNumber))
            let newURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(String(i))
            try! FileManager.default.removeItem(at: oldURL)
            let data = try! Data(contentsOf: newURL)
            try! data.write(to: oldURL)
            oldNameNumber = i
            i = i+1
        }
        theTotalNumberofPicture = theTotalNumberofPicture! - 1
    }
    
    
    //获取诗词数组
    func getTheLines()->Array<String>{
        linesbase!.tag = self.tag!
        return linesbase!.getlines()
    }
    
    //程序结束前一定要调用， 保存模型中的数据！！！
    func saveModel(){
        let fileurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("totalNumber")
        let data = String(theTotalNumberofPicture!).data(using: .utf8)
        try! data!.write(to: fileurl)
    }
    
    private func gettheNumber(){
        let fileurl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("totalNumber")
        if FileManager.default.fileExists(atPath: fileurl!.path){
        let data = try! Data(contentsOf: fileurl!)
        let str = String(data: data, encoding: .utf8)
        self.theTotalNumberofPicture = Int(str!)
        }else{
            self.theTotalNumberofPicture = 0
        }
    }
    
    
    
    
    
    
    init(){
        saveProcessor = saveCore()
        linesbase = lineBase()
        gettheNumber()
    }
    
    
    
    
   
    
    
    
}

