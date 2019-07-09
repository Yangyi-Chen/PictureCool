//
//  PersonalViewController.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/8.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var userID = "lighayes"
    var table:PersonalCenterTableView!
    override func viewDidLoad() {
        table = PersonalCenterTableView(frame: self.view.frame, style: .grouped)
        table.userID = self.userID
        table.refreshPicture()
        table.push = { (img) in
            let vc = AppriciateViewController()
            vc.nowImage = img
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        table.pick = {
            let picker = UIImagePickerController()
            picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.allowsEditing = true
            // picker.sourceType = sourceType
            self.present(picker, animated: true, completion: nil)
        }
        self.view.addSubview(table)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        loginCenter.shared.postTheUserPicture(userID: PictureProcessCore.shared.userID!, userPass: PictureProcessCore.shared.userPass!, userPicture: image, handler: {
            self.table.refreshPicture()
        })
        
    }
}
