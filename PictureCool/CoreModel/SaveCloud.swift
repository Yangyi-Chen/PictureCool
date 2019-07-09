//
//  SaveCloud.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import Alamofire
class saveCloud{
    
    private static var instance = saveCloud()
    
    class var shared:saveCloud {return instance}

    
    


    func sharePicture(image:UIImage,userID:String,userPass:String,handler:@escaping () -> ()){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/upload_base64.php", method: .post
            , parameters: constructBody(userID: userID, userPass: userPass, image: image), encoding: URLEncoding.default, headers: constructHead()).responseString{(response) in

                print(response)
                handler()
        }
    }
    
    
    
    func getAllpicture(hurdler:@escaping (NSArray) -> ()){
//        var imageArr:[UIImage] = []
//         var count = 0
//        var arrCount = 0
        
        
//        Alamofire.request(URL(string: "https://blog.cyyself.name/pic-upload-for-chenyangyi/list.php")!).responseData{(response) in
//            var arr:[String] = try! JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
//            let reArr:Array<String> = arr.reversed()
//            //arrCount = arr.count
////            for str in arr{
////                let wholeStr = "https://blog.cyyself.name/pic-upload-for-chenyangyi/upload/" + str
////                Alamofire.request(URL(string: wholeStr)!).responseData{(response) in
////                    let image = UIImage(data: response.data!)
////                    //TODO:  sss
////                    imageArr.append(image!)
////                    hurdler(image!)
////
////                count += 1
////                }
////            }
////            print("imageArr.count = \(imageArr.count)")
//            hurdler(reArr)
//
//        }
        //print("imageArr.count = \(imageArr.count)")
        
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/list_all.php").responseData{(response) in
            let arr = (try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)) as! NSArray
            hurdler(arr)
            
        }
        
    }
    
    func getAllTruePicture(arr:[String],handler:@escaping ([UIImage])->()){
        let queue = DispatchQueue(label: "requestHandler")
        let group = DispatchGroup()
        //weak var weakSelf =  self
        let sema = DispatchSemaphore(value: 0)
        var imageArr:[UIImage] = []
        
        for str in arr{
            queue.async(group: group) {
                let wholeStr = str
                Alamofire.request(URL(string: wholeStr)!).responseData{(response) in
                    let image = UIImage(data: response.data!)
                    //TODO:  sss
                    if image != nil{
                    imageArr.append(image!)
                    }
                    

                    sema.signal()
                    //count += 1

                }
                
                
                sema.wait()
            }
        }
        group.notify(queue: DispatchQueue.main, execute: { 
            //tableView同时用到了两个请求到返回结果
            
            //hud.hide(animated: true)
            handler(imageArr)
        })
    }
    
    
    func getUniqueUserPicture(userID:String,handler:@escaping (NSArray)->()){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/list_name.php", method: .post, parameters: constructUniqueUserPar(userID: userID), encoding: URLEncoding.default, headers: constructHead()).responseData{(response) in
            let arr = try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! NSArray
            print("userID is \(userID),arr.count = \(arr.count)")
            //TODO: dosomething with arr
            handler(arr)
            
        }
        
        
        
    }
    
    
    
    
    
    private func constructHead()->HTTPHeaders{
        var head = HTTPHeaders()
        head = ["content-type":"application/x-www-form-urlencoded"]
        return head
    }
//    private func constructBody(image:UIImage)->Parameters{
//        var par = Parameters()
//        //let image = UIImage(named: "dong")

    
    
    private func constructBody(userID:String,userPass:String,image:UIImage)->Parameters{
        var par = Parameters()
        let data = image.jpegData(compressionQuality: 1)
        let base64 = data?.base64EncodedString()
        par = [
            "name":userID,
            "pass":userPass,
            "type":"jpg",
            "data":base64!
        ]
        return par
    }
    
    
    
    private func constructUniqueUserPar(userID:String)->Parameters{
        var par = Parameters()
        par = [
            "name":userID
        ]
        
        return par
    }
    
    
    
    
}
