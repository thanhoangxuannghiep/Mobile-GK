//
//  manageKhuVucController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class manageKhuVucController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var list_kv = [KhuVuc]()
    @IBOutlet weak var manageKVTable: UITableView!
    var database : OpaquePointer?
    var param : UserDefaults?
    override func viewDidLoad() {
        super.viewDidLoad()
        param = UserDefaults()
        manageKVTable.dataSource = self
        manageKVTable.delegate = self
        getAll()
    }
    func getAll(){
        database = createDB()
        createTable_KhuVuc(database: database)
        list_kv.removeAll()
        let statement = getData(database: database, query: "select * from KhuVuc")
        while  sqlite3_step(statement) == SQLITE_ROW {
            let kv_temp = KhuVuc()
            kv_temp.maKV = Int(sqlite3_column_int(statement, 0))
            kv_temp.tenKV = String(cString: sqlite3_column_text(statement, 1))
            kv_temp.motaKV = String(cString: sqlite3_column_text(statement, 2))
            kv_temp.hinhURL = String(cString: sqlite3_column_text(statement, 3))
            list_kv.append(kv_temp)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return list_kv.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kv = list_kv[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageKVCell") as! ManageKVCell
        cell.lbTenKV.text = "Tên khu vực: " + kv.tenKV
        //let data = FileManager.default.contents(atPath: kv.hinhURL)
        cell.imgKV.image = UIImage(contentsOfFile: kv.hinhURL)
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAll()
        self.manageKVTable.reloadData() // Cập nhật giao diện
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "manageEditDetailKVSegue" {
            let indexPath = manageKVTable.indexPathForSelectedRow
            let index : Int! = indexPath?.row
            let idKV : Int = list_kv[index].maKV
            print("idKV: \(idKV)")
            param?.set(idKV, forKey: "currentRow")
            //myTable.reloadData()
        }
    }
}
