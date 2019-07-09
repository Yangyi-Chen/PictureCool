//
//  PersonalNavView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/8.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class PersonalNavView: UIView {
    @IBOutlet var contView: UIView!
    @IBOutlet weak var userID: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pCenter: UILabel!
    
    
    typealias changeValue=()->()
    var change:changeValue?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        initFromXib()
    }
    
    func initFromXib() {
        let bundle = Bundle.init(for: PersonalNavView.self)
        let nib = UINib(nibName: "PersonalNavView", bundle: bundle)
        contView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        contView.frame = bounds
        self.addSubview(contView)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        let tapGas = UITapGestureRecognizer()
        tapGas.addTarget(self, action: #selector(tapHead))
        imageView.addGestureRecognizer(tapGas)
        imageView.isUserInteractionEnabled = true
        //        cLabel.snp.makeConstraints { (make) in
        //            make.right.equalTo(self.vi)
        //        }
    }
    @objc func tapHead(){
        if PictureProcessCore.shared.userID == self.userID.text!{
        change!()
            print("1")
        }else{
            print("0")
        }
    }
}
