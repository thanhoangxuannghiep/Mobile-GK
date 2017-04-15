//
//  manageKhuVucController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class manageKhuVucController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var manageKVTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manageKVTable.dataSource = self
        manageKVTable.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.manageKVTable.reloadData() // Cập nhật giao diện
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return id.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageKVCell") as! ManageKVCell
        cell.lbTenKV.text = "Full name: "
        return cell
    }

}
