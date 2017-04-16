//
//  manageDetailMonAnController.swift
//  1542248-1542290-1542293
//
//  Created by Thanh Tung on 4/16/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class manageDetailMonAnController: UIViewController {

    @IBOutlet var txtTenMonAn: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTenMonAn.text="ABC"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
