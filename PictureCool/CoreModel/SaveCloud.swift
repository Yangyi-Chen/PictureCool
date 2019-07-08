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
    
    
    
    
    func sharePicture(image:UIImage,userID:String,userPass:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/upload_base64.php", method: .post
            , parameters: constructBody(userID: userID, userPass: userPass, image: image), encoding: URLEncoding.default, headers: constructHead()).responseString{(response) in
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
    
    
    func getUniqueUserPicture(userID:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/list_name.php", method: .post, parameters: constructUniqueUserPar(userID: userID), encoding: URLEncoding.default, headers: constructHead()).responseData{(response) in
            let arr = try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! NSArray
            //TODO: dosomething with arr
            
        }
        
        
        
    }
    
    
    
    
    
    private func constructHead()->HTTPHeaders{
        var head = HTTPHeaders()
        head = ["content-type":"application/x-www-form-urlencoded"]
        return head
    }
    
    
    
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
