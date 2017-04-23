//
//  UIExtension.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/17/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

extension UIViewController{
    func alert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void ) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func date_as_string(date : String) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm:ss +zzzz"
        let dateObj = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let str = dateFormatter.string(from: dateObj!)
        return str
    }
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for i in 0 ..< len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
}
