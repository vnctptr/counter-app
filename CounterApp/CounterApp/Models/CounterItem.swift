//
//  CounterItem.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-28.
//

import Foundation
import CloudKit

enum CounterRecordKeys: String {
    case type = "CounterItem"
    case name
    case count
}

struct CounterItem: Identifiable {
    var id = UUID()
    var recordId: CKRecord.ID?
    let name: String
    let count: Int
}

extension CounterItem {
    init?(record: CKRecord) {
        guard let name = record[CounterRecordKeys.name.rawValue] as? String,
              let count = record[CounterRecordKeys.count.rawValue] as? Int else { 
            return nil
        }
        
        self.init(recordId: record.recordID, name: name, count: count)
    }
}

extension CounterItem {
    var record: CKRecord {
        let record = CKRecord(recordType: CounterRecordKeys.type.rawValue)
        record[CounterRecordKeys.name.rawValue] = name
        record[CounterRecordKeys.count.rawValue] = count
        return record
    }
}
