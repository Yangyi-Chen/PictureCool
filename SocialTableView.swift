//
//  SocialTableView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class SocialTableView:UITableView,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate{
    var ePicture:[UIImage]?
    typealias pushValue = (UIImage)->()
    var push:pushValue?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ePicture!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SocialTableViewCell(style: .default, reuseIdentifier: "SocialTableViewCell")
        cell.pictureView.frame.size.height = ePicture![indexPath.row].size.height * cell.pictureView.frame.width / ePicture![indexPath.row].size.width 
        cell.pictureView.image = ePicture![indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = FakeSocialNavView()
        nib.awakeFromNib()
        return nib
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //push!(ePicture![indexPath.row])
        
    }
    
   
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ePicture![indexPath.row].size.height * (UIScreen.main.bounds.width/10*8) / ePicture![indexPath.row].size.width 
    }
    
    


    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(SocialTableViewCell.self, forCellReuseIdentifier: "SocialTableViewCell")
        self.backgroundColor = UIColor.tintDark
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        self.ePicture = [UIImage(named: "temp")] as! [UIImage]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
