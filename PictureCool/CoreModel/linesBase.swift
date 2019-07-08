//
//  linesBase.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/1.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import UIKit
import Kanna
import Alamofire
class lineBase{
    
    
    private static var instance = lineBase()
    
    class var shared:lineBase {return instance}
    
    var tag:String?
    var finalLines:String?
    
    
    func getlines(label:UILabel,ifFail:@escaping ()->()){
        
        
        
        let url = URL(string: "https://api.gushi.ci/" + tag!)
        let request = URLRequest(url: url!)
        let semaPhore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                
                return
            }
            let jsonobject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            let returnDic = jsonobject as! NSDictionary
            let str = returnDic["content"]
            if str != nil{
                self.finalLines = str as! String
            DispatchQueue.main.async {
                label.text = str as! String
            }
            }else{
                ifFail()
            }
            
            
            semaPhore.signal()
            
        }
        task.resume()
        _ = semaPhore.wait(timeout: DispatchTime.distantFuture)
        
    }
    
    func produceSentence(tag:String,handler:@escaping ([String],String)->()){
        let wholeURL = "http://www.ichacha.net/mzj/"+tag+".html"
        let verifiedURL = wholeURL.urlEncoded()
        Alamofire.request(verifiedURL).responseData{(response) in
            let WebPassage = String(data: response.data!, encoding: .utf8)
            let doc = try! HTML(html: WebPassage!, encoding: .utf8)
            var arr = Array<String>()
            for ti in doc.css("li"){
                arr.append(ti.text!)
            }
            //此时arr中 前五个元素是用tag造的句子
//            for i in 0...4{
//                print(arr[i])
//            }
            handler(arr,tag)
        }
    }
    
    
    
}




extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

