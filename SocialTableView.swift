//
//  SocialTableView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/4.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit
import ESPullToRefresh
import MJRefresh

class SocialTableView:UITableView,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate{
    var ePicture:[UIImage] = []
    var eHead:[UIImage] = []
    var eUsers:[String] = []
    
    typealias pushValue = (UIImage)->()
    var tapHead:UITapGestureRecognizer?
    var push:pushValue?
    typealias pushCValue = (String)->()
    var pushCenter:pushCValue?
    var nowArr:NSArray = []
    var nowIndex = 0
    
    var nowUserArr:[String] = []
    var nowUrlArr:[String] = []
    var nowHeadArr:[String] = []
    
    var zHeader = MJRefreshNormalHeader()
    var zFooter = MJRefreshAutoNormalFooter()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ePicture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SocialTableViewCell(style: .default, reuseIdentifier: "SocialTableViewCell")
        cell.pictureView.frame.size.height = ePicture[indexPath.row].size.height * cell.pictureView.frame.width / ePicture[indexPath.row].size.width
        cell.pictureView.image = ePicture[indexPath.row]
        cell.push = {
//            self.pushCenter!(self.eUsers[indexPath.row])
            self.pushCenter!(self.nowUserArr[indexPath.row])
        }
        cell.headView.setImage(eHead[indexPath.row], for: .normal)
//        tapHead = UITapGestureRecognizer()
//        tapHead?.addTarget(self, action: #selector(tapH))
//        cell.headView.addGestureRecognizer(tapHead!)
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
        push!(ePicture[indexPath.row])
        self.deselectRow(at: indexPath, animated: false)
    }
    
   
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ePicture[indexPath.row].size.height * (UIScreen.main.bounds.width/10*8) / ePicture[indexPath.row].size.width + 20
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if touch.view?.isKind(of: <#T##AnyClass#>)
//    }

    func devideArr(){
        saveCloud.shared.getAllpicture(hurdler: { (arr) in
            for i in arr{
                let dic = i as! NSDictionary
                self.nowHeadArr.append(dic["avatar"] as! String)
                self.nowUserArr.append(dic["name"] as! String)
                self.nowUrlArr.append(dic["url"] as! String)
                
            }
        })
    }
    func refreshData(){
        
        saveCloud.shared.getAllpicture(hurdler: { (arr) in
            self.nowHeadArr = []
            self.nowUserArr = []
            self.nowUrlArr = []
            for i in arr{
                let dic = i as! NSDictionary
                self.nowHeadArr.append(dic["avatar"] as! String)
                self.nowUserArr.append(dic["name"] as! String)
                self.nowUrlArr.append(dic["url"] as! String)
                
            }
            for i in self.nowUserArr{
                print(i)
            }
            //self.nowArr = arr
            var tempArr:[String] = []
            var tempHeadArr:[String] = []
            if self.nowHeadArr.count <= 4 {
                tempArr = self.nowUrlArr
                tempHeadArr = self.nowHeadArr
                self.nowIndex = self.nowUrlArr.count
            }else{
                for i in 0...3 {
                    tempArr.append(self.nowUrlArr[i])
                    tempHeadArr.append(self.nowHeadArr[i])
                }
                self.nowIndex = 4
            }
            saveCloud.shared.getAllTruePicture(arr: tempArr, handler: {(imageArr) in
                loginCenter.shared.getHeadFromUrl(arr: tempHeadArr, handler: {(head) in
                    self.mj_header.endRefreshing()
                    self.ePicture = []
                    self.eHead = []
                    self.eHead = head
                    self.ePicture = imageArr
                    self.reloadData()
                    })
                
                
            })
            
             print("nowUrlArr.count = \(self.nowUrlArr.count)")
        })
       
        
    }
    
    func setPullRefresh(){
//        self.es.addPullToRefresh {
//            self.refreshData()
//
//        }
//        self.es.addInfiniteScrolling {
//            var tempArr:[String] = []
//            for i in 0...3 {
//                if self.nowIndex != self.nowArr.count{
//                tempArr.append(self.nowArr[self.nowIndex])
//                    self.nowIndex = self.nowIndex+1
//                }else{
//                    //self.nowIndex =
//                    break
//                }
//            }
//            saveCloud.shared.getAllTruePicture(arr: tempArr, handler: {(imageArr) in
//                for i in imageArr {
//                    self.ePicture.append(i)
//                }
//                self.reloadData()
//            })
//            self.es.stopLoadingMore()
//            if self.nowIndex == self.nowArr.count {self.es.noticeNoMoreData()}
//        }
        zHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.mj_header = zHeader
        
        zFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.mj_footer = zFooter
        self.zHeader.beginRefreshing()
    }
    
    @objc func headerRefresh(){
        self.refreshData()
    }
    
    @objc func footerRefresh(){
        var tempArr:[String] = []
        var tempHeadArr:[String] = []
        for i in 0...3 {
            if self.nowIndex != self.nowUrlArr.count{
                tempArr.append(self.nowUrlArr[self.nowIndex])
                tempHeadArr.append(self.nowHeadArr[self.nowIndex])
                self.nowIndex = self.nowIndex+1
            }else{
                //self.nowIndex =
                break
            }
        }
        saveCloud.shared.getAllTruePicture(arr: tempArr, handler: {(imageArr) in
            loginCenter.shared.getHeadFromUrl(arr: tempHeadArr, handler: { (head) in
                for i in imageArr {
                    self.ePicture.append(i)
                }
                for j in head{
                    self.eHead.append(j)
                }
                self.reloadData()
                self.mj_footer.endRefreshing()
                if self.nowIndex == self.nowUrlArr.count {self.mj_footer.endRefreshingWithNoMoreData()}
            })
            
        })
        
    }

    

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(SocialTableViewCell.self, forCellReuseIdentifier: "SocialTableViewCell")
        self.backgroundColor = UIColor.tintDark
        //self.refreshData()
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
