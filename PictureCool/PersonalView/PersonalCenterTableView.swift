//
//  PersonalCenterTableView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/8.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class PersonalCenterTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    var ePicture:[UIImage] = []
    var nowUrlArr:[String] = []
    var userID:String = "lighayes"
    var headImg:UIImage?
    var headUrl:String?
    typealias pickValue = ()->()
    var pick:pickValue?
    typealias pushValue = (UIImage)->()
    var push:pushValue?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ePicture.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ePicture[indexPath.row].size.height * (UIScreen.main.bounds.width/10*8) / ePicture[indexPath.row].size.width + 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PersonalCenterTableViewCell(style: .default, reuseIdentifier: "PersonalCenterTableViewCell")
        cell.pictureView.frame.size.height = ePicture[indexPath.row].size.height * cell.pictureView.frame.width / ePicture[indexPath.row].size.width
        cell.pictureView.image = ePicture[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push!(ePicture[indexPath.row])
        self.deselectRow(at: indexPath, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = PersonalNavView()
        nib.awakeFromNib()
        nib.userID.text = userID
//        loginCenter.shared.gettheUserPicture(userID: userID) { (make) in
//            nib.imageView.image = make
//        }
        nib.imageView.image = headImg
        nib.change = {
            
            self.pick!()
            
        }
        return nib
    }
    
    func refreshPicture(){
        saveCloud.shared.getUniqueUserPicture(userID: userID) { (arr) in
            self.nowUrlArr = []
            for i in arr{
                let temp = i as! NSDictionary
                self.nowUrlArr.append(temp["url"] as! String)
                
            }
            print("nowUrlARr is \(self.nowUrlArr.count)")
            saveCloud.shared.getAllTruePicture(arr: self.nowUrlArr, handler: { (arr) in
                loginCenter.shared.gettheUserPicture(userID: self.userID, handler: { (img) in
                    self.headImg = img
                    
                    self.ePicture = arr
                    print("epicture.count is \(self.ePicture.count)")
                    self.reloadData()
                })
                
            })
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(PersonalCenterTableViewCell.self, forCellReuseIdentifier: "PersonalCenterTableViewCell")
        self.backgroundColor = UIColor.tintDark
        //self.refreshData()
        //ePicture = [UIImage(named: "temp")] as! [UIImage]
        //refreshPicture()
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
