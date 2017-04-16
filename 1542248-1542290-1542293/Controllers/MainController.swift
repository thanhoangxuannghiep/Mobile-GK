//
//  MainController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTable: UITableView!
    var database : OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        database = createDB()
        createTable_MonAn(database: database)
        createTable_KhuVuc(database: database)
        createTable_BanAn(database: database)
        createTable_HoaDon(database: database)
        createTable_CTHD(database: database)
        mainTable.delegate = self
        mainTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTable.reloadData() // Cập nhật giao diện
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return id.count
    }
    func test()
    {
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainCell
        cell.lbTenBanAn.text = "Full name: "
        cell.lbKhuVuc.text = "Grade: "
//        cell.lbDoB.text = " - Day of Birth: "  + date_as_string(date: dob[indexPath.row])!
//        cell.lbOther.text = "Other Info: " + other[indexPath.row]
        return cell
    }
}
