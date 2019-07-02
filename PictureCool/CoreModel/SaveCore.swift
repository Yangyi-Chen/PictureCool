//
//  SaveCore.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/6/30.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import Foundation
import UIKit
class saveCore{
    
<<<<<<< HEAD
    func save(image:UIImage, nameNumber:String){
=======
    
    
    
    
    
    
    
    static func save(image:UIImage, nameNumber:String){
>>>>>>> bc4b9435ae046103e45a4802723d1bdb7e42c178
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(nameNumber)
        let data = image.jpegData(compressionQuality: 1)
        try! data!.write(to: fileURL)
    }
    
    static func getPicture(nameNumber:String)-> UIImage{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(nameNumber)
        let data = try! Data(contentsOf: fileURL)
        let image = (UIImage(data: data))!
        return image
    }
    
    
}
