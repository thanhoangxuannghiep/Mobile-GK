//
//  manageDetailKhuVucController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit
//protocol AddDetailKhuVucDelegate {
//    func AddKV(kv: KhuVuc)
//}
class manageDetailKhuVucController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgKV: UIImageView!
    @IBOutlet weak var txtMoTaKV: UITextView!
    @IBOutlet weak var txtTenKV: UITextField!
    let imagePicker = UIImagePickerController()
    
    var database : OpaquePointer?
    var imagesDirectoryPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = createDB()
        createTable_KhuVuc(database: database)
        imagesDirectoryPath = createFolder_Image(folder_name: "ImageKhuVuc")
        
        let saveKV = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addKV))
        self.navigationItem.setRightBarButton(saveKV, animated: true)
        
        imagePicker.delegate = self
    }
    @IBAction func addImageKV(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }
    func addKV(){
        var imgName_temp = randomStringWithLength(len: 6) as String
        imgName_temp = (imgName_temp as String) + ".jpg"
        let data = UIImageJPEGRepresentation(img, 1.0)
        let imagePath = imagesDirectoryPath! + "/\(imgName_temp as String)"
        
        let ten = txtTenKV.text!
        let mota = txtMoTaKV.text!
        let kv = KhuVuc()
        kv.tenKV = ten
        kv.motaKV = mota
        kv.hinhURL = imagePath
        let query = "INSERT INTO KhuVuc (ten_khu_vuc, mo_ta, hinhURL) VALUES (?, ?, ?)"
        if kv.insert(database: database, query: query, kv:kv){
            _ = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
            alert(title: "Success", message: "Area has been added!") { _ in
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
