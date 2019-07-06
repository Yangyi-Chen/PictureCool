//
//  VerifyPicture.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/6.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
class VerifyCore{
    
    var Token:String?
    
    
    
    func varifyPicture(imageSpecial:UIImage){
        getTheToken()
        while(Token == nil){
            
        }
        Alamofire.request(URL(string: "https://aip.baidubce.com/api/v1/solution/direct/img_censor"+"?access_token="+Token!)!,
                          method: .post,
                          parameters: constructParameters(image: imageSpecial),
                          encoding: JSONEncoding.default,
                          headers: constructHeader()).responseData{(response) in
                            let flag = ((((try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! NSDictionary)["result"] as! NSDictionary)["antiporn"] as! NSDictionary)["conclusion"]) as! String
                            if(flag == "正常"){
                                
                            }else{
                                
                            }
                            
        }
        
    }
    
    
    
    
    
}




extension VerifyCore{
    private func getTheToken(){
        var str = String()
        let fileURL = URL(string: "https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=lU1GjcYbi5Is93eCRbwvZPtd&client_secret=CEKCB7ZiFhgGVB5WTbgIgW9p0ba77io2&")
        let request = URLRequest(url: fileURL!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            str = (try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary)["access_token"] as! String
            self.Token = str
        }
        task.resume()
    }
    
    
    private func constructHeader()->HTTPHeaders{
        var head = HTTPHeaders()
        head = [
            "Content-Type" : "application/json"
        ]
        return head
    }
    
    
    
    private func constructParameters(image:UIImage)->Parameters{
        var par = Parameters()
        let fileData = image.jpegData(compressionQuality: 1)
        let base64 = fileData!.base64EncodedString(options: .endLineWithLineFeed)
        par = [
            "image" :base64,
            "scenes":["antiporn"]
        ]
        return par
    }
}
