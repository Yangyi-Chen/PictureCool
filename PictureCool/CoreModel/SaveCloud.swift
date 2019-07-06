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

    
    
    func sharePicture(image:UIImage,handler:@escaping () -> ()){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/upload_base64.php", method: .post
            , parameters: constructBody(image: image), encoding: URLEncoding.default, headers: constructHead()).responseString{(response) in
                print(response)
                handler()
        }
    }
    
    
    
    func getAllpicture(hurdler:@escaping (Array<String>) -> ()){
//        var imageArr:[UIImage] = []
//         var count = 0
//        var arrCount = 0
        Alamofire.request(URL(string: "https://blog.cyyself.name/pic-upload-for-chenyangyi/list.php")!).responseData{(response) in
            var arr:[String] = try! JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
            let reArr:Array<String> = arr.reversed()
            //arrCount = arr.count
//            for str in arr{
//                let wholeStr = "https://blog.cyyself.name/pic-upload-for-chenyangyi/upload/" + str
//                Alamofire.request(URL(string: wholeStr)!).responseData{(response) in
//                    let image = UIImage(data: response.data!)
//                    //TODO:  sss
//                    imageArr.append(image!)
//                    hurdler(image!)
//
//                count += 1
//                }
//            }
//            print("imageArr.count = \(imageArr.count)")
            hurdler(reArr)
            
        }
        //print("imageArr.count = \(imageArr.count)")
        
    }
    
    func getAllTruePicture(arr:[String],handler:@escaping ([UIImage])->()){
        let queue = DispatchQueue(label: "requestHandler")
        let group = DispatchGroup()
        //weak var weakSelf =  self
        let sema = DispatchSemaphore(value: 0)
        var imageArr:[UIImage] = []
        
        for str in arr{
            queue.async(group: group) {
                let wholeStr = "https://blog.cyyself.name/pic-upload-for-chenyangyi/upload/" + str
                Alamofire.request(URL(string: wholeStr)!).responseData{(response) in
                    let image = UIImage(data: response.data!)
                    //TODO:  sss
                    imageArr.append(image!)
                    
                    sema.signal()
                    //count += 1
                }
                
                
                sema.wait()
            }
        }
        group.notify(queue: DispatchQueue.main, execute: {[weak self] in
            //tableView同时用到了两个请求到返回结果
            
            //hud.hide(animated: true)
            handler(imageArr)
        })
    }
    
    private func constructHead()->HTTPHeaders{
        var head = HTTPHeaders()
        head = ["content-type":"application/x-www-form-urlencoded"]
        return head
    }
    private func constructBody(image:UIImage)->Parameters{
        var par = Parameters()
        //let image = UIImage(named: "dong")
        let data = image.jpegData(compressionQuality: 1)
        let base64 = data?.base64EncodedString()
        par = [
            "type":"jpg",
            "data":base64!
        ]
        return par
    }

    
    
    
    
}
