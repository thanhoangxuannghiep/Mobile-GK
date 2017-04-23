//
//  manageEditKhuVucController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/18/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit
//protocol EditKVControllerDelegate {
//    func EditKV()
//}
class manageEditKhuVucController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgKV: UIImageView!
    @IBOutlet weak var motaKV: UITextView!
    @IBOutlet weak var tenKV: UITextField!
    var database : OpaquePointer?
    var param : UserDefaults?
    var imgFolderKV : String?
    let imagePicker = UIImagePickerController()
    var idKV: Any?
    let kv = KhuVuc()
    //did load
    override func viewDidLoad() {
        database = createDB()
        param = UserDefaults()
        imgFolderKV = createFolder_Image(folder_name: "ImageKhuVuc")
        super.viewDidLoad()
        createTable_KhuVuc(database: database)
        let saveKV = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(updateKV))
        self.navigationItem.setRightBarButton(saveKV, animated: true)
        let delKV = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(DelKV))
        self.navigationItem.setLeftBarButton(delKV, animated: true)
        idKV = param?.object(forKey: "currentRow")
        print("id KV: \(idKV)")
        let query = "select * from KhuVuc where id = ?"
        let selectStatement : OpaquePointer = kv.getKVByID(database: database, query: query, id: String(describing: idKV!))!
        while sqlite3_step(selectStatement) == SQLITE_ROW{
            kv.maKV = idKV as! Int
            kv.tenKV = String(cString: sqlite3_column_text(selectStatement, 1))
            tenKV.text = kv.tenKV
            print("id KV: \(idKV)")
            kv.motaKV = String(cString: sqlite3_column_text(selectStatement, 2))
            motaKV.text = kv.motaKV
            print("id KV: \(idKV)")
            kv.hinhURL = String(cString: sqlite3_column_text(selectStatement, 3))
            imgKV.image = UIImage(contentsOfFile: (kv.hinhURL)!)
        }
        imagePicker.delegate = self
    }
    var changeImg = false
    @IBAction func btnUpdateImage(_ sender: Any) {
        present(imagePicker, animated: true)
        changeImg = true
    }
    func updateKV(){
        var imagePath : String?
        var data : Data?
        if changeImg == true{
            var imgName_temp = randomStringWithLength(len: 6) as String
            imgName_temp = (imgName_temp as String) + ".jpg"
            imagePath = imgFolderKV! + "/\(imgName_temp as String)"
            data = UIImageJPEGRepresentation(img, 1.0)
            kv.hinhURL = imagePath
        }
        kv.tenKV = tenKV.text
        kv.motaKV = motaKV.text
        let query = "Update KhuVuc SET ten_khu_vuc = ?, mo_ta = ?, hinhURL = ? where id = " + String(describing: idKV!)
        if kv.update(database: database, query: query, kv: kv){
            _ = FileManager.default.createFile(atPath: imagePath!, contents: data, attributes: nil)
            alert(title: "Success", message: "Khu vực đã được cập nhật!") { _ in
                // Quay lại màn hình trước đó
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func DelKV(){
        let query = "Delete From KhuVuc where id = " + String(describing: idKV!)
        if delete(database: database, query: query){
            alert(title: "Success", message: "Khu Vực đã bị xoá!") { _ in
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    var img = UIImage()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img = pickedImage // Đưa vào hàng đợi để lưu
            imgKV.image = img
            dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

}
