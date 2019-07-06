//
//  LoginView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class LoginView: UIView {
    @IBOutlet var contView: UIView!

    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var goRegister: UIButton!
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
    }
    
    @objc func gotoRegister(){
        go!()
    }
}
