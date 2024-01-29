//
//  CounterItem.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-28.
//

import Foundation
import CloudKit

struct CounterItem {
    var recordId: CKRecord.ID?
    let name: String
    let count: Int
}

extension CounterItem {
    var record: CKRecord {
        let record = CKRecord(recordType: "CounterItem")
        record["name"] = name
        record["count"] = count
        return record
    }
}
