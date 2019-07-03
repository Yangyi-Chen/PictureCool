//
//  DetectPicture.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/2.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import Alamofire
class detectCore{
    
    var Token:String?
    private var firstElement:String?
    private var secondElement:String?
    var image:UIImage?
    
    
    
    
    //获取图片中的主要元素，  Main！！ set the tag in linebase here
    func getTheMainElement()->String{
        return firstElement!
    }
    
    //获取图片中次要元素
    func getTheSecondElement()->String{
        return secondElement!
    }
    
    
    
    init(image:UIImage){
        getinformation(image: image)
    }
    
    
    
    
    private func getinformation(image:UIImage){
        getTheToken()
        while(Token == nil){
            
        }
        Alamofire.request(URL(string: "https://aip.baidubce.com/rest/2.0/image-classify/v2/advanced_general"+"?access_token="+Token!)!,
                          method: .post,
                          parameters: constructParameters(image: image),
                          encoding: URLEncoding.default,
                          headers: constructHeader()).responseJSON{(response) in
                            let jsonData = response.data!
                            let arr = (try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary)["result"] as! NSArray
                            self.firstElement = (arr[0] as! NSDictionary)["keyword"] as! String
                            self.secondElement = (arr[1] as! NSDictionary)["keyword"] as! String
                            print(self.firstElement)
        }
    }
    
    
    
    
    
    
    
    
}


extension detectCore{
    private func getTheToken(){
        var str = String()
        let fileURL = URL(string: "https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=9B1EGGFaSXFO5vAtjvFvcMcA&client_secret=asWynhSgerV7Uy8LlELokVsMz4ylqroV&")
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
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
        return head
    }
    
    
    
    private func constructParameters(image:UIImage)->Parameters{
        var par = Parameters()
        
        let fileData = image.jpegData(compressionQuality: 1)
        let base64 = fileData!.base64EncodedString(options: .endLineWithLineFeed)
        par = [
            "image" : base64
        ]
        
        return par
    }
}
