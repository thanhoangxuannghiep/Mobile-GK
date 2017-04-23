//
//  KhuVucOperators.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/19/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import Foundation
import UIKit

extension KhuVuc{
    public func insert(database: OpaquePointer?, query: String?, kv: KhuVuc) -> Bool{
        var insertStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &insertStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(insertStatement, 1, kv.tenKV, -1, nil)
            sqlite3_bind_text(insertStatement, 2, kv.motaKV, -1, nil)
            sqlite3_bind_text(insertStatement, 3, kv.hinhURL, -1, nil)
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
    public func update(database: OpaquePointer?, query: String?, kv: KhuVuc) -> Bool{
        var updateStatement : OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &updateStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(updateStatement, 1, kv.tenKV, -1, nil)
            sqlite3_bind_text(updateStatement, 2, kv.motaKV, -1, nil)
            sqlite3_bind_text(updateStatement, 3, kv.hinhURL, -1, nil)
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
    func getKVByID(database: OpaquePointer?, query: String?, id: String?) -> OpaquePointer?{
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
