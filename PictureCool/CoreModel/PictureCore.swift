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

    
    var theTotalNumberofPicture:Int?
    
    let linesbase:lineBase?
    var picturebase:PictureBase?

    
    var status = 0
    var userID:String?
    var userPass:String?
    
    

    private static var instance = PictureProcessCore()
    
    class var shared:PictureProcessCore {return instance}


    //存图片
    func savePicture(image:UIImage){
        saveCore.save(image: image, nameNumber: String(theTotalNumberofPicture!))
        theTotalNumberofPicture = theTotalNumberofPicture! + 1
        print("in save num is \(theTotalNumberofPicture)")
    }
    
    //提取图片
    func getPicture(nameNumber:String)-> UIImage{
        return saveCore.getPicture(nameNumber: nameNumber)
    }
    
    
    
    //提取所有图片
    func getAllPicture()->Array<UIImage>{
        var array = Array<UIImage>()
        var i = 0
        print("in get num is \(theTotalNumberofPicture)")
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
    
    func getUserIDandStatus(){
        let userURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("userID")
        if FileManager.default.fileExists(atPath: userURL.path){
        let data = try! Data(contentsOf: userURL)
        userID = String(data: data, encoding: .utf8)
        }
        
        let passURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("userPass")
        if FileManager.default.fileExists(atPath: passURL.path){
            let data3 = try! Data(contentsOf: passURL)
            userPass = String(data: data3, encoding: .utf8)
        }
        
        let statusurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor:nil,create:false).appendingPathComponent("status")
        
        if FileManager.default.fileExists(atPath: statusurl.path){
        
        
        let data2 = try! Data(contentsOf: statusurl)
        let str = String(data: data2, encoding: .utf8)
        status = Int(str!)!
        }
        
        
        
        
    }

    //获取诗词 随机一句
    func getTheLines(tag:String,label:UILabel)->String{
        let newTag = picturebase?.match(matchString: tag)
        var isNIL = false
        linesbase!.tag = newTag
        linesbase?.getlines(label: label, ifFail:{
            isNIL = true
        })
        if isNIL {
            return "none"
        }else{
        return linesbase!.finalLines!
        }
    }
    
    
    
    
    
    //程序结束前一定要调用， 保存模型中的数据！！！
    func saveModel(){
        let fileurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("totalNumber")
        let data = String(theTotalNumberofPicture!).data(using: .utf8)
        try! data!.write(to: fileurl)
        
        let statusurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor:nil,create:true).appendingPathComponent("status")
        let statusdata = String(status).data(using: .utf8)
        try! statusdata?.write(to: statusurl)
        
        let userIDurl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("userID")
        if userID != nil{
            let userIDData = userID!.data(using: .utf8)
            try! userIDData!.write(to: userIDurl)
        }
        
        let passUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil,create: true).appendingPathComponent("userPass")
        if userPass != nil{
            let passData = userPass!.data(using: .utf8)
        try! passData?.write(to: passUrl)
        }
        
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

        
        linesbase = lineBase()
        gettheNumber()
        getUserIDandStatus()
        picturebase = PictureBase()
    }
    
    
    
    
   
    
    
    
}

