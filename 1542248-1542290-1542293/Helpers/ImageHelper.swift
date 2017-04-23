//
//  ImageHelper.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/17/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

extension UIViewController{
    func createFolder_Image(folder_name: String?) -> String?{

        var imagesDirectoryPath: String?
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // Create a new path for the new images folder
        imagesDirectoryPath = paths.appendingPathComponent(folder_name!).path
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath!, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath!, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        print("\(imagesDirectoryPath)")
        return imagesDirectoryPath
    }
}
