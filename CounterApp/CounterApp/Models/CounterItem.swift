//
//  CounterItem.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-28.
//

import Foundation
import CloudKit
import SwiftUI

enum CounterRecordKeys: String {
    case type = "CounterItem"
    case name
    case count
    case color
    case colorHex
    case archived
}

struct CounterItem: Identifiable {
    var id = UUID()
    var recordId: CKRecord.ID?
    var name: String
    var count: Int
    var color: Color
    var colorHex: String
    var archived: Bool
}

extension CounterItem {
    init?(record: CKRecord) {
        guard let name = record[CounterRecordKeys.name.rawValue] as? String,
              let count = record[CounterRecordKeys.count.rawValue] as? Int,
              let archived = record[CounterRecordKeys.archived.rawValue] as? Bool,
              let colorHex = record[CounterRecordKeys.colorHex.rawValue] as? String,
              let colorData = record[CounterRecordKeys.color.rawValue] as? Data,
              let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else {
            return nil
        }

        self.init(recordId: record.recordID, name: name, count: count, color: Color(uiColor), colorHex: colorHex, archived: archived)
    }
}

extension CounterItem {
    var record: CKRecord {
        let record = CKRecord(recordType: CounterRecordKeys.type.rawValue)
        record[CounterRecordKeys.name.rawValue] = name
        record[CounterRecordKeys.count.rawValue] = count
        record[CounterRecordKeys.colorHex.rawValue] = colorHex
        record[CounterRecordKeys.archived.rawValue] = archived

        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(color), requiringSecureCoding: false) {
            record[CounterRecordKeys.color.rawValue] = colorData
        }

        return record
    }
}

var sampleCounters: [CounterItem] = [
    .init(name: "Books", count: 12, color: Color.coralAccent, colorHex: colorToHexString(color: UIColor(Color.coralAccent)), archived: false)
]
