//
//  DB.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/8/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

extension UIViewController {
    func createDB() -> OpaquePointer?{
        //create db in document dir
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = docURL.appendingPathComponent("QLNH.db").path
        
        var dbTempPointer : OpaquePointer?
        if sqlite3_open(dataPath, &dbTempPointer) == SQLITE_OK{
            print("DB was created!")
            print(dataPath)
            return dbTempPointer
        }else{
            print("Failed")
            return nil
        }
    }
    
    func createTable_MonAn(database : OpaquePointer?){
        let query = "create table MonAn(id integer primary key autoincrement, ten_mon_an nvarchar(50), mo_ta nvarchar(200), hinhURL string, gia_tien float)"
        //let query = "drop table Student"
        var statement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Mon An was created!")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
        }
    }
    
    func createTable_KhuVuc(database : OpaquePointer?){
        let query = "create table KhuVuc(id integer primary key autoincrement, ten_khu_vuc nvarchar(50), mo_ta nvarchar(200), hinhURL string)"
        //let query = "drop table Grade"
        var statement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK{
            if(sqlite3_step(statement) == SQLITE_DONE){
                print("Khu Vuc created!")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
        }
    }
    
    func createTable_BanAn(database : OpaquePointer?){
        let query = "create table BanAn(id integer primary key autoincrement, hinhURL string, id_kv integer, status bool)"
        var statement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK{
            if(sqlite3_step(statement) == SQLITE_DONE){
                print("Ban An was created!")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
        }
    }
    
    func createTable_HoaDon(database : OpaquePointer?){
        let query = "create table HoaDon(id integer primary key autoincrement, id_ban integer, status bool, ngay_lap date, tong_tien float)"
        var statement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK{
            if(sqlite3_step(statement) == SQLITE_DONE){
                print("Hoa Don was created!")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
        }
    }
    
    func createTable_CTHD(database : OpaquePointer?){
        let query = "create table CTHD(idHD integer, idMA integer, so_luong integer, thanh_tien float)"
        var statement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK{
            if(sqlite3_step(statement) == SQLITE_DONE){
                print("CTHD was created!")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
        }
    }
    
    func insert(database: OpaquePointer?, query: String?) -> Bool{
        var insertStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Inserted")
                return true
            }else{
                print("Failed")
                return false
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
            return false
        }
    }
    
    func getData(database: OpaquePointer?, query: String?) -> OpaquePointer?{
        var selectStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &selectStatement, nil) == SQLITE_OK{
            return selectStatement
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
            return nil
        }
    }
    func update(database: OpaquePointer?, query: String?) -> Bool{
        var updateStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &updateStatement, nil) == SQLITE_OK{
            if(sqlite3_step(updateStatement) == SQLITE_DONE){
                print("updated!")
                return true
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
                return false
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
            return false
        }
    }
    func delete(database: OpaquePointer?, query: String?)-> Bool{
        var deleteStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &deleteStatement, nil) == SQLITE_OK{
            if(sqlite3_step(deleteStatement) == SQLITE_DONE){
                print("Deleted!")
                return true
            }else{
                let errmsg = String(cString: sqlite3_errmsg(database))
                print(errmsg)
                return false
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
            return false
        }
    }
}
