//
//  RegisterView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterView:UIView,UITextFieldDelegate{
    @IBOutlet var contView: UIView!
    @IBOutlet weak var goLogin: UIButton!
    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var userName: UITextField!
    
    typealias goValue = ()->()
    var go:goValue?
    var pick:goValue?

    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //initFromXib()
    }
    func initFromXib() {
        let bundle = Bundle.init(for: RegisterView.self)
        let nib = UINib(nibName: "RegisterView", bundle: bundle)
        contView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        contView.frame = bounds
        self.addSubview(contView)
        goLogin.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
       headImage.image = UIImage(named: "Unknown")
        headImage.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(tapHead))
        headImage.addGestureRecognizer(tapGes)
        registerBtn.addTarget(self, action: #selector(regist), for: .touchUpInside)
        
        userName.delegate = self
        passWord.delegate = self
        
    }
    
    @objc func regist(){
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        if userName.text == "" || passWord.text == "" {
            hud.label.text = "用户名或密码不能为空"
            hud.hide(animated: true, afterDelay: 0.5)
        }else{
            loginCenter.shared.register(userID: userName.text!, userPass: passWord.text!, handler: { (status) in
            //let hud = MBProgressHUD.showAdded(to: self, animated: true)
            if status == 1{
                loginCenter.shared.postTheUserPicture(userID: self.userName.text!, userPass: self.passWord.text!, userPicture: self.headImage.image!)
                hud.label.text = "注册成功"
                hud.hide(animated: true, afterDelay: 0.5)
                self.gotoLogin()
            }else{
                hud.label.text = "注册失败"
                hud.hide(animated: true, afterDelay: 0.5)
            }
        })
        }
    }
    
    @objc func gotoLogin(){
        go!()
    }
    @objc func tapHead(){
        pick!()
        print("pick")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
