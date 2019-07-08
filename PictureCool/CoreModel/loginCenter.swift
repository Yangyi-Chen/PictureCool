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
    
}
