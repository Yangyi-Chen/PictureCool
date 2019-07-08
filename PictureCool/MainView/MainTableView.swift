//
//  MainTableView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/2.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class MainTableView: UITableView,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    var allPicture:[UIImage]?
    typealias pushValue = (UIImage)->()
    var push:pushValue?
    
    typealias refreshValue = ()->()
    var refresh:refreshValue?
    
    typealias goValue = ()->()
    var gotoLoginC:goValue?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPicture!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableViewCell(style: .default, reuseIdentifier: "MainTableViewCell")
        cell.pictureView.image = allPicture![indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = FakeNavigationView()
        nib.awakeFromNib()
        nib.go = {
            self.gotoLoginC!()
        }
        return nib
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push!(allPicture![indexPath.row])
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        PictureProcessCore.shared.deletePicture(nameNumber: String(indexPath.row))
//        allPicture = PictureProcessCore.shared.getAllPicture()
//        self.deleteRows(at: [indexPath], with: .left)
//        PictureProcessCore.shared.saveModel()
//        //reloadData()
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction.init(style: .destructive, title: "delete") { (row, indexPath) in
            
                PictureProcessCore.shared.deletePicture(nameNumber: String(indexPath.row))
            self.allPicture = PictureProcessCore.shared.getAllPicture()
                self.deleteRows(at: [indexPath], with: .left)
                PictureProcessCore.shared.saveModel()
        }
        let pushAction = UITableViewRowAction.init(style: .normal, title: "push") { (row, indexPath) in
            
            self.gotoLoginC!()
            saveCloud.shared.sharePicture(image: self.allPicture![indexPath.row],handler:{
                self.refresh!()
            })
           
        }
        return [delete,pushAction]
    }
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if (touch.view?.isKind(of: MainTableViewCell.self))! {
//            return true
//        }else{
//            return false
//        }
//    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        allPicture = PictureProcessCore.shared.getAllPicture()
        print("allPictue.count = \(allPicture!.count)")
        self.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        self.delegate=self
        self.dataSource=self
        self.separatorStyle = .none
        self.rowHeight=150
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
