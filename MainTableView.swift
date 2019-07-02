//
//  MainTableView.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/2.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class MainTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var allPicture:[UIImage]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPicture!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableViewCell(style: .default, reuseIdentifier: "MainTableViewCell")
        cell.imageView?.image = allPicture![indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = FakeNavigationView()
        nib.awakeFromNib()
        return nib
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        let core = PictureProcessCore()
        allPicture = core.getAllPicture()
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
