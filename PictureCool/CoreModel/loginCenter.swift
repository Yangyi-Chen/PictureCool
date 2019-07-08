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
    
    
    private static var instance = loginCenter()
    
    class var shared:loginCenter {return instance}
    
    func register(userID:String,userPass:String,handler:@escaping (Int)->()){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/register.php", method: .post, parameters: constructParameters(userID: userID, userPass: userPass), encoding: URLEncoding.default, headers: constructHead()).responseData{(response) in
            let status = (try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! Dictionary<String,Any>)["stat"] as!  Int
            
            handler(status)
        }
    }
    
    
    func login(userID:String,userPass:String,handler:@escaping (Int)->()){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/login.php", method: .post, parameters: constructParameters(userID: userID, userPass: userPass), encoding: URLEncoding.default, headers: constructHead()).responseData{(response) in
            let status = (try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! Dictionary<String, Any>)["stat"] as! Int
            handler(status)
            
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
    
    //通过用户的账号，获取用户密码，实现在本地不需要每次打开都登录
    func getthePassword(userID:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/get_password.php", method: .post, parameters: constructgetUserPasswordParameters(userID: userID), encoding: URLEncoding.default, headers: constructHead()).responseData(completionHandler: {(response)  in
            let password = (try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! NSDictionary)["pass"] as! String
            //TODO:  do something with  the password
            
            
        })
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
    
    private func constructgetUserPasswordParameters(userID:String)->Parameters{
        var par = Parameters()
        par = [
            "name":userID
        ]
        
        return par
    }
    
    
    
}
