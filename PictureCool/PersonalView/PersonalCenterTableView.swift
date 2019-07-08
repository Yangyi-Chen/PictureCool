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
    var userID:String = "lighayes"
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
        nib.imageView.image = ZImageMaker.makeUserImage()
        return nib
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(PersonalCenterTableViewCell.self, forCellReuseIdentifier: "PersonalCenterTableViewCell")
        self.backgroundColor = UIColor.tintDark
        //self.refreshData()
        ePicture = [UIImage(named: "temp")] as! [UIImage]
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
