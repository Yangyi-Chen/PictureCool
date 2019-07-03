//
//  linesBase.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/7/1.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import UIKit
class lineBase{
    
    
    
    
    var tag:String?
    var finalLines:String?
    
    
    func getlines(label:UILabel){
        
        let url = URL(string: "https://api.gushi.ci/" + tag!)
        let request = URLRequest(url: url!)
        let semaPhore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let str = ((try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, String>)["content"])!
            self.finalLines = str
            DispatchQueue.main.async {
                 label.text = str
            }
           
            
            semaPhore.signal()
            
        }
        task.resume()
        _ = semaPhore.wait(timeout: DispatchTime.distantFuture)
        
    }
    
    
    
    
    
}
