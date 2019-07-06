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
    
    
    
    
    func sharePicture(image:UIImage){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/upload_base64.php", method: .post
            , parameters: constructBody(), encoding: URLEncoding.default, headers: constructHead()).responseString{(response) in
                print(response)
        }
    }
    
    
    
    func getAllpicture(){
        Alamofire.request(URL(string: "https://blog.cyyself.name/pic-upload-for-chenyangyi/list.php")!).responseData{(response) in
            let arr = try! JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Array<String>
            for str in arr{
                let wholeStr = "https://blog.cyyself.name/pic-upload-for-chenyangyi/upload/" + str
                Alamofire.request(URL(string: wholeStr)!).responseData{(response) in
                    let image = UIImage(data: response.data!)
                    //TODO:  sss
                    
                    
                    
                
                }
            }
        }
    }
    
    private func constructHead()->HTTPHeaders{
        var head = HTTPHeaders()
        head = ["content-type":"application/x-www-form-urlencoded"]
        return head
    }
    private func constructBody()->Parameters{
        var par = Parameters()
        let image = UIImage(named: "dong")
        let data = image?.jpegData(compressionQuality: 1)
        let base64 = data?.base64EncodedString()
        par = [
            "type":"jpg",
            "data":base64!
        ]
        return par
    }
    
    
    

    
    
    
    
}
