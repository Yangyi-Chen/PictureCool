//
//  DeleteController.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/6.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import Alamofire
class DeleteController{
    
    func deletePicture(at pictureNumber:String){
        Alamofire.request("https://blog.cyyself.name/pic-upload-for-chenyangyi/delete.php", method: .post, parameters: constructBody(atNumber: pictureNumber), encoding: URLEncoding.default, headers: constructHead()).responseString{(response) in
            print(response)
        }
    }
    
    
    private func constructHead()->HTTPHeaders{
        var head = HTTPHeaders()
        head =  ["content-type":"application/x-www-form-urlencoded"]
        return head
    }
    
    private func constructBody(atNumber:String)->Parameters{
        var par = Parameters()
        par = [
            "filename":atNumber
        ]
        return par
        
    }
}
