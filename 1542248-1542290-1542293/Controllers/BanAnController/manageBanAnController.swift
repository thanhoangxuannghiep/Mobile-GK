//
//  manageBanAnController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/19/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class manageBanAnController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var list_ba = [BanAn]()
    
    @IBOutlet weak var manageBATable: UITableView!
    var database : OpaquePointer?
    var param : UserDefaults?
    override func viewDidLoad() {
        super.viewDidLoad()
        param = UserDefaults()
        manageBATable.dataSource = self
        manageBATable.delegate = self
        getAll()
    }
    func getAll(){
        database = createDB()
        createTable_BanAn(database: database)
        list_ba.removeAll()
        let statement = getData(database: database, query: "select * from BanAn")
        while  sqlite3_step(statement) == SQLITE_ROW {
            let ba_temp = BanAn()
            ba_temp.maBA = Int(sqlite3_column_int(statement, 0))
            ba_temp.SoBA = String(cString: sqlite3_column_text(statement, 1))
            ba_temp.motaBA = String(cString: sqlite3_column_text(statement, 2))
            ba_temp.hinhURL = String(cString: sqlite3_column_text(statement, 3))
            ba_temp.maKV = Int(sqlite3_column_int(statement, 4))
            ba_temp.status = Int(sqlite3_column_int(statement, 5))
            list_ba.append(ba_temp)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return list_ba.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ba = list_ba[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageBanAnCell") as! ManageBanAnCell
        //xet status ban sau do set mau cho ban an. Green is available, Red is using, Yellow is ordered
        if ba.status == 0{
            cell.lbTenBA.textColor = UIColor.green
        }else if ba.status == 1{
            cell.lbTenBA.textColor = UIColor.red
        }else{
            cell.lbTenBA.textColor = UIColor.yellow
        }
        cell.lbTenBA.text! = "Bàn " + ba.SoBA!
        //get ten khu vuc
        let query = "select * from KhuVuc where id = " + String(describing: ba.maKV!)
        let selectStatement : OpaquePointer = getData(database: database, query: query)!
        while sqlite3_step(selectStatement) == SQLITE_ROW{
            cell.lbTenKV.text! = String(cString: sqlite3_column_text(selectStatement, 1))
        }
        print(ba.hinhURL!)
        cell.imgBA.image = UIImage(contentsOfFile: ba.hinhURL!)
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAll()
        self.manageBATable.reloadData() // Cập nhật giao diện
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! manageDetailBanAnController
        if segue.identifier == "manageEditDetailBASegue" {
            dest.title = "Chỉnh Sửa bàn ăn"
            let indexPath = manageBATable.indexPathForSelectedRow
            let index : Int! = indexPath?.row
            let idBA : Int = list_ba[index].maBA!
            param?.set(idBA, forKey: "currentBA")
            //myTable.reloadData()
        }else if segue.identifier == "manageAddDetailBASegue" {
            dest.title = "Thêm bàn ăn"
            param?.set(nil, forKey: "currentBA")
            param?.set(0, forKey: "currentBA")
        }
    }
}
