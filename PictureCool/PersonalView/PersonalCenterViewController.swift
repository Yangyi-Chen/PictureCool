//
//  PersonalViewController.swift
//  PictureCool
//
//  Created by lighayes on 2019/7/8.
//  Copyright © 2019 flyingPigs. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController {
    var userID = "lighayes"
    override func viewDidLoad() {
        let table = PersonalCenterTableView(frame: self.view.frame, style: .grouped)
        table.userID = self.userID
        self.view.addSubview(table)
    }
}
