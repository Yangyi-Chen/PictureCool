//
//  LoginView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginView: UIView,UITextFieldDelegate {
    @IBOutlet var contView: UIView!

    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var goRegister: UIButton!
    
    typealias popValue = ()->()
    var pop:popValue?
//    lazy var passWord:UITextField = { ()->UITextField in
//        let temp = UITextField()
//        temp.frame.size.width = 300
//        temp.placeholder = "PassWord"
//        return temp
//    }()
//    lazy var userName:UITextField = { ()->UITextField in
//        let temp = UITextField()
//        temp.frame.size.width = 300
//        temp.placeholder = "PassWord"
//        return temp
//    }()
//    lazy var loginBtn:UITextField = { ()->UITextField in
//        let temp = UITextField()
//        temp.frame.size.width = 300
//        temp.placeholder = "PassWord"
//        return temp
//    }()
//    lazy var middleView:UIView = { ()->UIView in
//        let temp = UIView()
//        temp.frame.size = CGSize(width: 240, height: 204)
//        temp.backgroundColor = UIColor.rose
//        return temp
//    }()
    
    typealias goValue = () -> ()
    var go:goValue?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXib()
    }
    func initFromXib() {
        let bundle = Bundle.init(for: LoginView.self)
        let nib = UINib(nibName: "LoginView", bundle: bundle)
        contView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        contView.frame = bounds
        self.addSubview(contView)
        goRegister.addTarget(self, action: #selector(gotoRegister), for: .touchUpInside)
        userName.delegate = self
        passWord.delegate = self
        
        loginbtn.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func login(){
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        if userName.text == "" || passWord.text == "" {
            hud.label.text = "用户名或密码不能为空"
            hud.hide(animated: true, afterDelay: 0.5)
        }else{
            loginCenter.shared.login(userID: userName.text!, userPass: passWord.text!,handler:{ (status) in 
                if status == 1{
                    hud.label.text = "登陆成功"
                    hud.hide(animated: true, afterDelay: 0.5)
                    PictureProcessCore.shared.status = 1
                    PictureProcessCore.shared.userID = self.userName.text!
                    PictureProcessCore.shared.saveModel()
                    self.pop!()
                }else{
                    hud.label.text = "用户名或密码错误"
                    hud.hide(animated: true, afterDelay: 0.5)
                }
            })
        }
    }
    
    @objc func gotoRegister(){
        go!()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
