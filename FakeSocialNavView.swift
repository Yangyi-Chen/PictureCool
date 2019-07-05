//
//  FakeSocialNavView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class FakeSocialNavView:UIView{
    @IBOutlet var contView: UIView!
    @IBOutlet weak var cLabel: UILabel!
    @IBOutlet weak var chineseLabel: UILabel!
    var tapGes:UITapGestureRecognizer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
        tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(gotoPersonalMain))
        self.addGestureRecognizer(tapGes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXib()
    }
    func initFromXib() {
        let bundle = Bundle.init(for: FakeSocialNavView.self)
        let nib = UINib(nibName: "FakeSocialNavView", bundle: bundle)
        contView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        contView.frame = bounds
        self.addSubview(contView)
//        cLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(self.vi)
//        }
    }
    @objc func gotoPersonalMain(){
        
    }
}
