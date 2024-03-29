//
//  ViewController.swift
//  PictureCool
//
//  Created by 无敌帅的yyyyy on 2019/6/29.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class ViewController: UIViewController,CAAnimationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    var animationView:AnimationView!
    var tapGes:UITapGestureRecognizer!
    var tableView:MainTableView!
    var socialTable:SocialTableView!
    
    lazy var scrollView = { () -> UIScrollView in
        let temp = BasicScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        return temp
    }()
    lazy var camera = { () -> UIButton in
        let temp = UIButton()
        temp.setImage(ZImageMaker.bigCameraImage(), for: .normal)
        temp.tintColor = UIColor.white

        temp.addTarget(self, action: #selector(cameraBtnTarget(btn:)), for: .touchUpInside)
        temp.isHidden = true
        
        return temp
    }()
    
    lazy var photoBook = { () -> UIButton in
        let temp = UIButton()
        temp.setImage(ZImageMaker.bigPhotoBookImage(), for: .normal)
        temp.tintColor = UIColor.white
        temp.addTarget(self, action: #selector(photoBookBtnTarget(btn:)), for: .touchUpInside)
        temp.isHidden = true

        return temp
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.animationView.addPushBehavior()
        self.tableView.allPicture = PictureProcessCore.shared.getAllPicture()
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnimationView()
        //addTitleBar()
        addTableView()
        addScrollView()
        setAddButton()
        addTapGes()
        // Do any additional setup after loading the view.
    }

    private func addAnimationView(){
        animationView = AnimationView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        //self.view.addSubview(animationView)
    }
    
    private func addTitleBar(){
         let nib = FakeNavigationView()
        nib.awakeFromNib()
        self.view.addSubview(nib)
    }
    
    private func setAddButton(){
        let addBtn = UIButton(frame: CGRect(x: self.view.bounds.width/2-35, y: self.view.bounds.height-100, width: 70, height: 70))
        addBtn.tintColor = UIColor.white
        
        addBtn.setImage(ZImageMaker.makeAddImage(), for: .normal)
//        let imageView = UIImageView(image: ZImageMaker.makeAddImage())
//        imageView.frame = CGRect(x: self.view.bounds.width/2-35, y: self.view.bounds.height-100, width: 70, height: 70)
//        imageView.tintColor = UIColor.white
        addBtn.addTarget(self, action: #selector(addBtnTarget(btn:)), for: .touchUpInside)
        addBtn.tag = 0
        //self.view.addSubview(imageView)
        
        self.view.addSubview(camera)
        self.view.addSubview(photoBook)
        self.view.addSubview(addBtn)
        
        camera.snp.makeConstraints { (make) in
            make.centerX.equalTo(addBtn.snp.centerX)
            make.centerY.equalTo(addBtn.snp.centerY)
        }
        
        photoBook.snp.makeConstraints { (make) in
            make.centerX.equalTo(addBtn.snp.centerX)
            make.centerY.equalTo(addBtn.snp.centerY)
        }
    }
    
    private func addTapGes(){
        tapGes = UITapGestureRecognizer()
        tapGes.addTarget(self, action: #selector(tapGesTarget(sender:)))
        tapGes.delegate = self
        self.tableView.addGestureRecognizer(tapGes)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isKind(of: MainTableView.self))! {
            return true
        }else{
            return false
        }
    }
    
    @objc func tapGesTarget(sender:UITapGestureRecognizer){
        self.animationView.addPushBehavior()
        let nowPoint = sender.location(in: self.animationView)
        if ((self.camera.layer.presentation()?.hitTest(nowPoint)) != nil) {
            cameraBtnTarget(btn: camera)
        }
        if ((self.photoBook.layer.presentation()?.hitTest(nowPoint)) != nil) {
            photoBookBtnTarget(btn: photoBook)
        }
    }
    
    @objc func addBtnTarget(btn:UIButton){
        let rotationAnim = AnimationTool.baseAnimationWithKeyPath("transform.rotation.z", fromValue: nil, toValue: 3/4*CGFloat.pi, duration: 0.3, repeatCount: 1, timingFunction: CAMediaTimingFunctionName.linear.rawValue, isRemove: false)
        let positionAnimRight = AnimationTool.baseAnimationWithKeyPath("position", fromValue: nil, toValue: NSValue(cgPoint: CGPoint(x: self.view.frame.width/2+100, y: self.view.bounds.height-150)), duration: 0.3, repeatCount: 1, timingFunction: CAMediaTimingFunctionName.linear.rawValue, isRemove: false)
        let positionAnimLeft = AnimationTool.baseAnimationWithKeyPath("position", fromValue: nil, toValue: NSValue(cgPoint: CGPoint(x: self.view.frame.width/2-100, y: self.view.bounds.height-150)), duration: 0.3, repeatCount: 1, timingFunction: CAMediaTimingFunctionName.linear.rawValue, isRemove: false)
        let scaleAnim = AnimationTool.baseAnimationWithKeyPath("transform.scale", fromValue: nil, toValue: 1, duration: 0.3, repeatCount: 1, timingFunction: CAMediaTimingFunctionName.linear.rawValue, isRemove: false)
        let animGroupRight = CAAnimationGroup()
        animGroupRight.fillMode = CAMediaTimingFillMode.forwards
        animGroupRight.isRemovedOnCompletion = false
        animGroupRight.animations = [scaleAnim,positionAnimRight]
        let animGroupLeft = CAAnimationGroup()
        animGroupLeft.isRemovedOnCompletion = false
        animGroupLeft.fillMode = CAMediaTimingFillMode.forwards
        animGroupLeft.animations = [scaleAnim,positionAnimLeft]
        
        if btn.tag == 0{
            btn.tag = 1
            camera.isHidden = false
            photoBook.isHidden = false
            scaleAnim.byValue = 0.2
            
            btn.layer.add(rotationAnim, forKey: nil)
            //camera.layer.add(animGroupRight, forKey: nil)
            //camera.layer.add(scaleAnim, forKey: "transform.scale.z")
            //photoBook.layer.add(animGroupLeft, forKey: nil)
          //  photoBook.layer.add(scaleAnim, forKey: "transform.scale.z")
           
            
            UIView.animate(withDuration: 0.3, animations: {
                self.camera.center = CGPoint(x: self.view.frame.width/2+100, y: self.view.bounds.height-150)
                self.photoBook.center = CGPoint(x: self.view.frame.width/2-100, y: self.view.bounds.height-150)
            }) { (true) in
                
            }
            
        }else{
            btn.tag = 0
            animGroupLeft.delegate = self
            animGroupRight.delegate = self
            
            positionAnimRight.toValue = NSValue(cgPoint: CGPoint(x: self.view.frame.width/2, y: self.view.bounds.height-65))
            positionAnimLeft.toValue = NSValue(cgPoint: CGPoint(x: self.view.frame.width/2, y: self.view.bounds.height-65))
            scaleAnim.toValue = 0.2
            rotationAnim.toValue = 0
            
            animGroupRight.animations = [scaleAnim,positionAnimRight]
            animGroupLeft.animations = [scaleAnim,positionAnimLeft]
            
            btn.layer.add(rotationAnim, forKey: nil)
            //camera.layer.add(animGroupRight, forKey: nil)
            //photoBook.layer.add(animGroupLeft, forKey: nil)
            UIView.animate(withDuration: 0.3, animations: {
                self.camera.center = btn.center
                self.photoBook.center = btn.center
            }) { (true) in
                self.camera.isHidden = true
                self.photoBook.isHidden = true
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        camera.isHidden = true
        photoBook.isHidden = true
    }
    
    @objc func cameraBtnTarget(btn:UIButton){
        var imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if imagePicker == nil{
                imagePicker = UIImagePickerController()
            }
            imagePicker.delegate = self
            //设置图片来源为相机
            //imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            //弹出警告框
            let errorAlert = UIAlertController(title: "相机不可用", message: "", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.cancel, handler: nil)
            errorAlert.addAction(cancelAction)
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    @objc func photoBookBtnTarget(btn:UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        //picker.allowsEditing = true
       // picker.sourceType = sourceType
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("get picture")
        self.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let vc = PictureEditController()
        vc.nowImage = image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addTableView(){
        tableView = MainTableView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        tableView.backgroundColor = nil
        tableView.push = { (make) in
            let vc = AppriciateViewController()
            vc.nowImage = make
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.refresh = {
            self.socialTable.zHeader.beginRefreshing()
            
            //self.socialTable.reloadData()
        }
        tableView.gotoLoginC = {
            self.gotoLoginViewController()
        }
        tableView.gotoPerCenter = {
            let vc = PersonalCenterViewController()
            vc.userID = PictureProcessCore.shared.userID!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.makeSuccHud = {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.label.text = "push成功！"
            hud.hide(animated: true, afterDelay: 1)
        }
        
        tableView.makeFailHud = {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.label.text = "图片非法"
            hud.hide(animated: true, afterDelay: 1)
        }
        
        //self.view.addSubview(tableView)
        
        socialTable = SocialTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        socialTable.push = {
            (make) in
            let vc = AppriciateViewController()
            vc.nowImage = make
            self.navigationController?.pushViewController(vc, animated: true)
        }
        socialTable.pushCenter = { (make) in
            let vc = PersonalCenterViewController()
            vc.userID = make
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func gotoLoginViewController(){
        let vc = PersonalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addScrollView(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(animationView)
        scrollView.addSubview(tableView)
        scrollView.addSubview(socialTable)
        
    }
//    private func setCameraPhotoBtn(){
//        let camera = UIButton()
//        let photoBook = UIButton()
//        camera.setImage(ZImageMaker.makeCameraImage(), for: .normal)
//        photoBook.setImage(ZImageMaker.makePhotoBookImage(), for: .normal)
//        camera.tintColor = UIColor.white
//        photoBook.tintColor = UIColor.white
//
//        self.view.addSubview(camera)
//        self.view.addSubview(photoBook)
//
//        camera.snp.makeConstraints { (make) in
//            make.centerX.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
//        }
//    }
}

