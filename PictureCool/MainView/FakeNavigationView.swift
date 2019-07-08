//
//  FakeNavigationView.swift
//  PictureCool
//
//  Created by lighayes on 2019/6/30.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class FakeNavigationView: UIView {
    @IBOutlet weak var titleMain: UILabel!
    @IBOutlet weak var titleNext: UILabel!
    @IBOutlet var contView: UIView!
    @IBOutlet weak var userBtn: UIButton!
    
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
        let bundle = Bundle.init(for: FakeNavigationView.self)
        let nib = UINib(nibName: "FakeNavigationView", bundle: bundle)
        contView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        contView.frame = bounds
        self.addSubview(contView)
        userBtn.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        userBtn.layer.cornerRadius = 20
        userBtn.clipsToBounds = true
        userBtn.tintColor = nil
        var image = UIImage()
        if PictureProcessCore.shared.status == 1 {
//            loginCenter.shared.gettheUserPicture(userID: PictureProcessCore.shared.userID!,handler:{(im) in
//                image = im
//                self.userBtn.setImage(image, for: .normal)
//            })
           userBtn.setImage(ZImageMaker.makeUserImage(), for: .normal)
        }else{
        userBtn.setImage(ZImageMaker.makeUserImage(), for: .normal)
        }
    }
    
    @objc func tapToLogin(){
        go!()
    }
    private func addTitle(){
//        let title = UILabel(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
//        title.text = "PICTURE COOL"
//        title.font.withSize(25)
//        title.textColor = UIColor.white
//        let title = UILabel(frame: CGRect(x: 0, y: 50, width: 100, height: 50))
//        title.text = "PICTURE COOL"
//        title.font.withSize(25)
//        title.textColor = UIColor.white
    }
}
