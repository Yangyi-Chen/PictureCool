//
//  GetInformation.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/6/30.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class InformationCore{
    let AppID:String?
    let SecretID:String?
    let SecretKey:String?
    let qqID:String?
    let image:UIImage?
    let webURL:String?
    
    
    func getInformation(){
        Alamofire.request(webURL!, method: .post, parameters: constructParameter(), encoding:URLEncoding.default, headers: constructHeader()).responseJSON{(response) in
            print(response)
        }
    }
    
    
    func constructHeader()->HTTPHeaders{
        var header = HTTPHeaders()
        header = [
            "Host":"api.youtu.qq.com",
            "Content-Length":"1000",          //MARK Modified
            "Content-Type":"text/json",
            "Authorization":getTheSignStr()
        ]
        return header
    }
    func constructParameter()-> Dictionary<String, String>{
        var dic = Dictionary<String, String>()
        dic = [
            "app_id":AppID!,
            "image":(image!.jpegData(compressionQuality: 1))!.base64EncodedString(options: .endLineWithLineFeed),
            "seq":"1234"
        ]
        return dic
    }
    
    
    
   
    
    
    private func getTheSignStr()->String{
        let originstr = getHMACStr()
        var str = String()
        str = originstr.toBase64()
        return str
    }
    
    
    
    
    
    
    
    init(image:UIImage){
        AppID = ""
        SecretID = ""
        SecretKey = ""
        qqID = "248618097"
        webURL = "http://api.youtu.qq.com/youtu/imageapi/imagetag"
        self.image = image
    }
    
    
    
    
}






extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension InformationCore{
    private func getTheOrigin()->String{
        var origin = String()
        origin = "u=" + qqID! + "&a=" + AppID! + "&k=" + SecretKey! + "&e=" + "1432970065" + "&t=1427786065&r=270494647&f="
        return origin
    }
    
    private func getHMACStr()->String{
        let origin = getTheOrigin()
        let hmacStr = origin.hmac(algorithm: .SHA1, key: SecretKey!)
        let str = hmacStr + origin
        return str
    }
}
