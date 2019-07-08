//
//  loginCenter.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/5.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import Alamofire
class loginCenter{
    
    func register(userID:String,userPass:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/register.php", method: .post, parameters: constructParameters(userID: userID, userPass: userPass), encoding: URLEncoding.default, headers: constructHead())
    }
    
    
    func login(userID:String,userPass:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/login.php", method: .post, parameters: constructParameters(userID: userID, userPass: userPass), encoding: URLEncoding.default, headers: constructHead()).responseData{(response) in
            let status = (try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! Dictionary<String, Any>)["stat"] as! Int
            if status == 1{
                // 验证成功
            }else{
                //验证失败
            }
            
        }
    }
    
    
    
    //注册的时候，更改头像时候，都调用这个函数
    func postTheUserPicture(userID:String,userPass:String,userPicture:UIImage){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/change_avatar.php", method: .post, parameters: constructPictureParameters(userID: userID, userPass: userPass, userPicture: userPicture), encoding: URLEncoding.default, headers: constructHead())
    }
    
    
    //获取用户图像
    func gettheUserPicture(userID:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/get_avatar_url.php", method: .post, parameters: constructgetPictureParameters(userID: userID), encoding: URLEncoding.default, headers: constructHead()).responseData{(response) in
            let image = UIImage(data: response.data!)
            //TODO: dosomething with image
            
            
            
        }
    
    }
    
    
    
    
    
    
    
}
extension loginCenter{
    
    private func constructParameters(userID:String,userPass:String)->Parameters{
        var par = Parameters()
        par = [
            "name":userID,
            "pass":userPass
        ]
        return par
    }
    
    private func constructHead()->HTTPHeaders{
        var head = HTTPHeaders()
        head =  ["content-type":"application/x-www-form-urlencoded"]
        return head
    }
    
    private func constructPictureParameters(userID:String,userPass:String,userPicture:UIImage)->Parameters{
        var par = Parameters()
        let fileData = userPicture.jpegData(compressionQuality: 1)
        let base64 = fileData!.base64EncodedString(options: .endLineWithLineFeed)
        par = [
            "name":userID,
            "pass":userPass,
            "data":base64
        ]
        return par
    }
    
    private func constructgetPictureParameters(userID:String)->Parameters{
        var par = Parameters()
        par = [
            "name":userID
        ]
        return par
    }
    
    
    
    
    
}
