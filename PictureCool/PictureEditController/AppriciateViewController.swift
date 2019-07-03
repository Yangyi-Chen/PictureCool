//
//  AppriciateViewController.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/2.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import Social

class AppriciateViewController: PictureEditController {
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        self.view.backgroundColor = UIColor.tintDark
        //addAnimationView()
        setAll()
        addSwipeGes()
        changeBtn()
    }
    
    private func changeBtn(){
        
        reloadBtn.isHidden = true
        pLabel.isHidden = true
    }
    override func setLabelInBtn() {
        saveToBookBtn.addSubview(createLabel(text: "保存\n到\n相册"))
        saveToTableBtn.addSubview(createLabel(text: "分享"))
    
    }
    override func saveToTable() {
        let image = nowImage!
        let imageArr:[UIImage] = [image]
        let activity:UIActivityViewController = UIActivityViewController(activityItems: imageArr, applicationActivities: nil)
        self.navigationController?.present(activity, animated: true, completion: nil)
    
    }
}
