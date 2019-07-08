//
//  LoginViewController.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    lazy var register = { () -> RegisterView in
        let temp = RegisterView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height))
        temp.awakeFromNib()
        return temp
        
    }()
    
//    lazy var login = { () -> LoginView in
//        let temp = LoginView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        temp.awakeFromNib()
//        return temp
//
//    }()
    override func viewDidLoad() {
        let login = LoginView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        login.awakeFromNib()
        login.pop = {
            self.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(register)
        self.view.addSubview(login)
        register.go = {
            self.register.frame.origin.y += self.view.frame.height
            login.frame.origin.y += self.view.frame.height
        }
        
        register.pick = {
            let picker = UIImagePickerController()
            picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.allowsEditing = true
            // picker.sourceType = sourceType
            self.present(picker, animated: true, completion: nil)
            print("pick")
        }

        login.go = {
            self.register.frame.origin.y -= self.view.frame.height
            login.frame.origin.y -= self.view.frame.height
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        self.register.headImage.image = image
    }
    
}
