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
        
        
        let catPictureURL = URL(string: "http://i.imgur.com/w5rkSIj.jpg")!

        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        cell.imgBanAn.image = UIImage(data: imageData)
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
//        cell.lbDoB.text = " - Day of Birth: "  + date_as_string(date: dob[indexPath.row])!
//        cell.lbOther.text = "Other Info: " + other[indexPath.row]
        return cell
    }
}
