//
//  manageDetailKhuVucController.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class manageDetailKhuVucController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgKV: UIImageView!
    @IBOutlet weak var txtMoTaKV: UITextView!
    @IBOutlet weak var txtTenKV: UITextField!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveKV = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addKV))
        self.navigationItem.setRightBarButton(saveKV, animated: true)
        imagePicker.delegate = self
    }
    @IBAction func addImageKV(_ sender: Any) {
        present(imagePicker, animated: true)
    }
    func addKV(){
    
    }
    var imgPath: UIImage?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPath = pickedImage // Đưa vào hàng đợi để lưu
            imgKV.image = pickedImage
            print(imgPath?.accessibilityValue)
            //image.data = UIImageJPEGRepresentation(selectedImage, 1) as NSData?
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

}
