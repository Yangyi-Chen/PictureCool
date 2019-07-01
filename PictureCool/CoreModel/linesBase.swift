//
//  linesBase.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/1.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
class lineBase{
    
    
    
    
    var tag:String?
    
    
    
    func getlines()->Array<String>{
        let request = URLRequest(url: URL(string: "https://api.gushi.ci/" + tag!)!)
        var strArr = Array<String>()
        var i = 0
        while(i<10){
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                let str = ((try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, String>)["content"])!
                strArr.append(str)
                
            }
            task.resume()
            i = i+1
        }
        return strArr
        
    }
    
    
    
    
    
    
}
