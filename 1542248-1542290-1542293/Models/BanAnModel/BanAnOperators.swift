//
//  BanAnOperators.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/19/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

extension BanAn{
    public func insert(database: OpaquePointer?, query: String?, ba: BanAn) -> Bool{
        var insertStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &insertStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(insertStatement, 1, ba.SoBA, -1, nil)
            sqlite3_bind_text(insertStatement, 2, ba.motaBA, -1, nil)
            sqlite3_bind_text(insertStatement, 3, ba.hinhURL, -1, nil)
            sqlite3_bind_int(insertStatement, 4, Int32(ba.maKV!))
            sqlite3_bind_int(insertStatement, 5, Int32(ba.status!))
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("inserted")
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
    public func update(database: OpaquePointer?, query: String?, ba: BanAn) -> Bool{
        var updateStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &updateStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(updateStatement, 1, ba.SoBA, -1, nil)
            sqlite3_bind_text(updateStatement, 2, ba.motaBA, -1, nil)
            sqlite3_bind_text(updateStatement, 3, ba.hinhURL, -1, nil)
            sqlite3_bind_int(updateStatement, 4, Int32(ba.maKV!))
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
    func getBAByID(database: OpaquePointer?, query: String?, id: String?) -> OpaquePointer?{
        var selectStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &selectStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(selectStatement, 1, id, -1, nil)
            return selectStatement
        }else{
            let errmsg = String(cString: sqlite3_errmsg(database))
            print(errmsg)
            return nil
        }
    }
}
