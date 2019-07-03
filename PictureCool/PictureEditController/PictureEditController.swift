//
//  PictureEditController.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/1.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import MBProgressHUD

class PictureEditController: UIViewController {
    
    var nowImage:UIImage?
    var panGes:UIPanGestureRecognizer?
    var reloadPan:UIPanGestureRecognizer?
    var labelPan:UIPanGestureRecognizer?
    var beganPanPoint:CGPoint?
    var detectcore:detectCore?
    var tag:String?
    
    
    
    
    
    
    lazy var pLabel = { () -> UILabel in
        let temp = UILabel()
        temp.frame.size = CGSize(width: 300, height: 100)
        temp.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        temp.font = temp.font.withSize(25)
        temp.adjustsFontSizeToFitWidth = true
        //temp.sizeToFit()
        temp.textColor = UIColor.rose
        return temp
    }()
    lazy var reloadBtn = { () -> UIButton in
        let temp = UIButton()
        temp.frame = CGRect(x: 100, y: 0, width: 60, height: 60)
        temp.layer.cornerRadius = temp.frame.width/2
        //temp.backgroundColor = UIColor.white
        temp.isUserInteractionEnabled = true
        temp.setImage(ZImageMaker.makeRefreshImage(), for: .normal)
        temp.tintColor = UIColor.white
        temp.addTarget(self, action:#selector(refresh), for: UIControl.Event.touchUpInside)
        return temp
    }()
    
    @objc private func refresh(){
        PictureProcessCore.shared.getTheLines(tag: (detectcore?.getTheMainElement())!, label: pLabel)
    }
    
    
    
    lazy var saveToBookBtn = { () -> UIButton in
        let temp = UIButton()
        temp.frame = CGRect(x: self.view.frame.width, y: 0, width: 100, height: self.view.frame.height/2)
        temp.backgroundColor = UIColor.darkGray
//        temp.setTitle("同时保存到相册与库", for: .normal)
//        temp.titleEdgeInsets = UIEdgeInsets(top: temp.frame.height/2-40, left: 25, bottom: temp.frame.height/2-40, right: 25)
//        temp.titleLabel?.font = UIFont(name: "黑体", size: 25)
//        temp.titleLabel?.textColor = UIColor.tintDark
        
        temp.addTarget(self, action: #selector(saveToBook), for: .touchUpInside)
        return temp
    }()
    
    lazy var saveToTableBtn = { () -> UIButton in
        let temp = UIButton()
        temp.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height/2, width: 100, height: self.view.frame.height/2)
        temp.backgroundColor = UIColor.tintDark
        
        temp.addTarget(self, action: #selector(saveToTable), for: .touchUpInside)
        return temp
    }()
    
    lazy var imageView = { () -> UIImageView in
        let temp = UIImageView()
        temp.layer.borderWidth = 0
        //temp.layer.cornerRadius = 15
        temp.layer.borderColor = UIColor.snow.cgColor
//        temp.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//        temp.frame.size = CGSize(width: self.view.frame.width-40, height: self.view.frame.height/5*2)
        temp.frame.size.width = self.view.frame.width
        temp.contentMode = .scaleAspectFit
        temp.clipsToBounds = true
        return temp
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //测试图片
        
        self.view.backgroundColor = UIColor.tintDark
        //addAnimationView()
        setAll()
        addSwipeGes()
        asyncGroupFunc()
    }
    
    private func addAnimationView(){
        let animationView = AnimationView(frame: self.view.frame)
        self.view.addSubview(animationView)
    }
    
     func setAll(){
        imageView.frame.size.height = nowImage!.size.height * imageView.frame.size.width / nowImage!.size.width
        imageView.center = self.view.center
        imageView.image = nowImage
        self.view.addSubview(imageView)
//        imageView.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view.snp.centerX)
//            make.top.equalTo(self.view.snp.top).offset(-20)
////            make.width.equalTo(self.view.frame.width).offset(-40)
////            make.height.equalTo(300)
//        }
        self.view.addSubview(saveToBookBtn)
        self.view.addSubview(saveToTableBtn)
        self.view.addSubview(reloadBtn)
        setLabelInBtn()
    }
    
    func setLabelInBtn()
    {
        
        saveToBookBtn.addSubview(createLabel(text: "同时\n保存\n到\n相册\n与库"))
        saveToTableBtn.addSubview(createLabel(text: "仅\n保存\n到库"))
    }
    
    func createLabel(text:String)->UILabel{
        let label = UILabel(frame: CGRect(x: 5, y: saveToTableBtn.frame.height/2-60, width: 90, height: 120))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont(name: "黑体", size: 40)
        //label.font.withSize(36)
        label.textColor = UIColor.white
        return label
    }
    
     func addSwipeGes(){
        panGes = UIPanGestureRecognizer()
        panGes!.addTarget(self, action: #selector(swipeLeft(sender:)))
  
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(panGes!)
        
        reloadPan = UIPanGestureRecognizer()
        reloadPan!.addTarget(self, action: #selector(panReload(sender:)))
  
        self.reloadBtn.isUserInteractionEnabled = true
        self.reloadBtn.addGestureRecognizer(reloadPan!)
        
        labelPan = UIPanGestureRecognizer()
        labelPan!.addTarget(self, action: #selector(panLabel(sender:)))
        
        self.pLabel.isUserInteractionEnabled = true
        self.pLabel.addGestureRecognizer(labelPan!)
    }
    
    private func getPictureToPoem(){
        self.imageView.addSubview(pLabel)
        //pLabel.center = imageView.center
        
        tag = detectcore?.getTheMainElement()
        let tempText = PictureProcessCore.shared.getTheLines(tag: (tag)!, label: pLabel)
        pLabel.text = tempText
        
    }
    
    private func asyncGroupFunc(){
        
//        let queue = DispatchQueue.init(label: "test", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        
        
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.show(animated: true)
            hud.labelText = "请等待"
//            self.detectcore = detectCore(image: self.nowImage!)
//
//
//            self.getPictureToPoem()
        
                //self.getPictureToPoem()
        let queue = DispatchQueue(label: "requestHandler")
        //分组
        let group = DispatchGroup()
        weak var weakSelf =  self
        //第一个网络请求，查询群信息
        let sema = DispatchSemaphore(value: 0)
        queue.async(group: group) {
            
            self.detectcore = detectCore(image: self.nowImage!)
            self.detectcore!.getinformation(imageSpecial: self.nowImage!){
                sema.signal()
                sema.signal()
                print("signal")
            }
            
            sema.wait()
        }
        group.notify(queue: DispatchQueue.main, execute: {[weak self] in
            //tableView同时用到了两个请求到返回结果
            
            hud.hide(animated: true)
            self!.getPictureToPoem()
        })
        
    }
    
    
    
    
    
    @objc func panLabel(sender:UIPanGestureRecognizer){
        if sender.state == .changed{
            pLabel.center = sender.location(in: self.imageView)
            
        }
        if sender.state == .ended{
            pLabel.center = sender.location(in: self.imageView)
        }
    }
    
    @objc func panReload(sender:UIPanGestureRecognizer){
        if sender.state == .changed{
            reloadBtn.center = sender.location(in: self.imageView)
            if reloadBtn.center.x < reloadBtn.frame.width/2{
                reloadBtn.center.x = reloadBtn.frame.width/2
            }
            if reloadBtn.center.x > self.view.frame.width - reloadBtn.frame.width/2{
                reloadBtn.center.x = self.view.frame.width - reloadBtn.frame.width/2
            }
            if reloadBtn.center.y < reloadBtn.frame.width/2{
                reloadBtn.center.y = reloadBtn.frame.width/2
            }
            if reloadBtn.center.y > self.view.frame.height - reloadBtn.frame.width/2{
                reloadBtn.center.y = self.view.frame.height - reloadBtn.frame.width/2
            }
        }
        if sender.state == .ended{
            var tempCenter = CGPoint(x: reloadBtn.center.x, y:0 )
//            if reloadBtn.center.x > self.view.frame.width/2 {
//                tempCenter.x = self.view.frame.width - reloadBtn.frame.width/2
//            }else{
//                tempCenter.x = reloadBtn.frame.width/2
//            }
            if reloadBtn.center.y > self.view.frame.height/2 {
                tempCenter.y = self.view.frame.height - reloadBtn.frame.width/2
            }else{
                tempCenter.y = reloadBtn.frame.height/2
            }
            UIView.animate(withDuration: 0.3) {
                self.reloadBtn.center = tempCenter
            }
        }
    }
    
    @objc func swipeLeft(sender:UIPanGestureRecognizer){
        if sender.state == .began{
            beganPanPoint = sender.translation(in: self.view)
            
        }
       
        if sender.state == .changed{
            var xPan = sender.translation(in: self.view).x - beganPanPoint!.x
            print("xPan is \(xPan)")
            
            self.imageView.frame.origin.x += xPan
            self.saveToTableBtn.frame.origin.x += xPan
            self.saveToBookBtn.frame.origin.x += xPan
            if self.imageView.frame.origin.x < -100{
                self.imageView.frame.origin.x = -100
            }
                if self.saveToTableBtn.frame.origin.x < -100+self.view.frame.width{
                    self.saveToTableBtn.frame.origin.x = -100+self.view.frame.width
                }
                if self.saveToBookBtn.frame.origin.x < -100+self.view.frame.width{
                    self.saveToBookBtn.frame.origin.x = -100+self.view.frame.width
                }
                if self.imageView.frame.origin.x > 0{
                    self.imageView.frame.origin.x = 0
                }
                if self.saveToTableBtn.frame.origin.x > self.view.frame.width{
                    self.saveToTableBtn.frame.origin.x = self.view.frame.width
                }
                if self.saveToBookBtn.frame.origin.x > self.view.frame.width{
                    self.saveToBookBtn.frame.origin.x = self.view.frame.width
                }
        }
    }
    @objc func saveToBook(){
        
        
    }
    
    @objc func saveToTable(){
        
        
        reloadBtn.isHidden = true
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.show(animated: true)
        hud.labelText = "请等待"
        
        
        let picture = DrawTool.drawIn(imageView: self.imageView)
            
        //hud.hide(animated: true)
        PictureProcessCore.shared.savePicture(image: picture)
        PictureProcessCore.shared.saveModel()
        self.navigationController?.popViewController(animated: true)
            
        
        
        
    }
    
}
