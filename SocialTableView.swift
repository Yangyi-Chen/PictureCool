//
//  SocialTableView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import ESPullToRefresh

class SocialTableView:UITableView,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate{
    var ePicture:[UIImage] = []
    typealias pushValue = (UIImage)->()
    var push:pushValue?
    var nowArr:[String] = []
    var nowIndex = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ePicture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SocialTableViewCell(style: .default, reuseIdentifier: "SocialTableViewCell")
        cell.pictureView.frame.size.height = ePicture[indexPath.row].size.height * cell.pictureView.frame.width / ePicture[indexPath.row].size.width
        cell.pictureView.image = ePicture[indexPath.row]
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
        return ePicture[indexPath.row].size.height * (UIScreen.main.bounds.width/10*8) / ePicture[indexPath.row].size.width + 20
    }
    
    func refreshData(){
        ePicture = []
        saveCloud.shared.getAllpicture(hurdler: { (arr) in
            self.nowArr = arr
            var tempArr:[String] = []
            if self.nowArr.count <= 4 {
                tempArr = self.nowArr
                self.nowIndex = self.nowArr.count
            }else{
                for i in 0...3 {
                    tempArr.append(self.nowArr[i])
                    
                }
                self.nowIndex = 4
            }
            saveCloud.shared.getAllTruePicture(arr: tempArr, handler: {(imageArr) in
                self.ePicture = imageArr
                self.reloadData()
            })
            
             print("nowArr.count = \(self.nowArr.count)")
        })
       
        
    }
    
    func setPullRefresh(){
        self.es.addPullToRefresh {
            self.refreshData()
            self.es.stopPullToRefresh()
        }
        self.es.addInfiniteScrolling {
            var tempArr:[String] = []
            for i in 0...3 {
                if self.nowIndex != self.nowArr.count{
                tempArr.append(self.nowArr[self.nowIndex])
                    self.nowIndex = self.nowIndex+1
                }else{
                    //self.nowIndex =
                    break
                }
            }
            saveCloud.shared.getAllTruePicture(arr: tempArr, handler: {(imageArr) in
                for i in imageArr {
                    self.ePicture.append(i)
                }
                self.reloadData()
            })
            self.es.stopLoadingMore()
            if self.nowIndex == self.nowArr.count {self.es.noticeNoMoreData()}
        }
    }

    

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(SocialTableViewCell.self, forCellReuseIdentifier: "SocialTableViewCell")
        self.backgroundColor = UIColor.tintDark
        self.refreshData()
        self.setPullRefresh()
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        //self.ePicture = [UIImage(named: "temp")] as! [UIImage]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
