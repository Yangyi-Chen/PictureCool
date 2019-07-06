//
//  RegisterView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class RegisterView:UIView{
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
       headImage.backgroundColor = UIColor.white
        headImage.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(tapHead))
        headImage.addGestureRecognizer(tapGes)
        
    }
    
    @objc func gotoLogin(){
        go!()
    }
    @objc func tapHead(){
        pick!()
        print("pick")
    }
}
