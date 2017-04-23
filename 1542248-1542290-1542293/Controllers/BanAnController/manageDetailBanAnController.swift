//
//  manageDetailBanAnController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/19/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class manageDetailBanAnController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerKV: UIPickerView!
    var list_kv = [KhuVuc]()
    var ba = BanAn()
    var idBA: Any?
    @IBOutlet weak var txtSoBA: UITextField!
    @IBOutlet weak var txtMoTaBA: UITextField!
    @IBOutlet weak var imgBA: UIImageView!
    @IBOutlet weak var txtKhuVuc: UITextField!
    var param : UserDefaults?
    let imagePicker = UIImagePickerController()
    var database : OpaquePointer?
    var imagesDirectoryPath: String?
    override func viewDidLoad() {
        pickerKV.isHidden = true
        database = createDB()
        param = UserDefaults()
        super.viewDidLoad()
        //get folder contains image of table
        imagesDirectoryPath = createFolder_Image(folder_name: "ImageBanAn")
        //get id ban an
        idBA = param?.object(forKey: "currentBA")
        if idBA as! Int == 0{
            print("add")
            let saveBA = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addBA))
            self.navigationItem.setRightBarButton(saveBA, animated: true)
        }else{
            print("edit")
            //load current table
            let query = "select * from BanAn where id = " + String(describing: idBA!)
            let selectStatement : OpaquePointer = getData(database: database, query: query)!
            while sqlite3_step(selectStatement) == SQLITE_ROW{
                txtSoBA.text! = String(cString: sqlite3_column_text(selectStatement, 1))
                txtMoTaBA.text! = String(cString: sqlite3_column_text(selectStatement, 2))
                imgBA.image = UIImage(contentsOfFile: String(cString: sqlite3_column_text(selectStatement, 3)))
                txtKhuVuc.text! = String(describing: sqlite3_column_int(selectStatement, 4))
//                txt = Int(sqlite3_column_int(selectStatement, 5))
            }
            //declare buttons
            let delBA = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(DelBA))
            self.navigationItem.setLeftBarButton(delBA, animated: true)
            let saveBA = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(updateBA))
            self.navigationItem.setRightBarButton(saveBA, animated: true)
        }
        imagePicker.delegate = self
    }
    //load all area in db
    @IBAction func btnChonKV(_ sender: Any) {
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
        pickerKV.delegate = self
        pickerKV.dataSource = self
        pickerKV.isHidden = false
    }
    //add & update BA
    func addBA(){
        var imgName_temp = randomStringWithLength(len: 6) as String
        imgName_temp = (imgName_temp as String) + ".jpg"
        let data = UIImageJPEGRepresentation(img, 1.0)
        let imagePath = imagesDirectoryPath! + "/\(imgName_temp as String)"

        ba.hinhURL = imagePath
        ba.maKV = Int(txtKhuVuc.text!)
        ba.SoBA = txtSoBA.text!
        ba.motaBA = txtMoTaBA.text!
        ba.status = 0
        let query = "INSERT INTO BanAn (so_ban_an, mo_ta_ban_an, hinhURL, id_KV, status) VALUES (?, ?, ?, ?, ?)"
        if ba.insert(database: database, query: query, ba: ba){
            _ = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
            alert(title: "Success", message: "Thêm bàn ăn thành công!") { _ in
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func updateBA(){
        var imagePath : String?
        var data : Data?
        if ChangeImg == true{
            var imgName_temp = randomStringWithLength(len: 6) as String
            imgName_temp = (imgName_temp as String) + ".jpg"
            imagePath = imagesDirectoryPath! + "/\(imgName_temp as String)"
            data = UIImageJPEGRepresentation(img, 1.0)
            ba.hinhURL = imagePath
        }
        ba.maKV = Int(txtKhuVuc.text!)
        ba.SoBA = txtSoBA.text!
        ba.motaBA = txtMoTaBA.text!
        let query = "Update BanAn SET so_ban_an = ?, mo_ta_ban_an = ?, hinhURL = ?, id_kv = ? where id = " + String(describing: idBA!)
        if ba.update(database: database, query: query, ba: ba){
            _ = FileManager.default.createFile(atPath: imagePath!, contents: data, attributes: nil)
            alert(title: "Success", message: "Bàn ăn đã được cập nhật!") { _ in
                // Quay lại màn hình trước đó
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func DelBA(){
        let query = "Delete From BanAn where id = " + String(describing: idBA!)
        if delete(database: database, query: query){
            alert(title: "Success", message: "Bàn ăn đã bị xoá!") { _ in
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    //function for UIImage picker
    var ChangeImg = false
    @IBAction func btnThemHinhBA(_ sender: Any) {
        present(imagePicker, animated: true)
        if idBA as! Int != 0{
            ChangeImg = true
        }
    }
    var img = UIImage()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img = pickedImage // Đưa vào hàng đợi để lưu
            imgBA.image = img
            dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    //function for UIPicker
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list_kv.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: list_kv[row].maKV!) + " - " + list_kv[row].tenKV
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtKhuVuc.text = String(describing: list_kv[row].maKV!)
        pickerKV.isHidden = true
    }
}
