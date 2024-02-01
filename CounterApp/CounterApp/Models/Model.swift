//
//  Model.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-30.
//

import Foundation
import CloudKit

@MainActor
class Model: ObservableObject {
    
    private var db = CKContainer.default().privateCloudDatabase
    @Published private var countersDictionary: [CKRecord.ID: CounterItem] = [:]
    
    var counters: [CounterItem] {
        countersDictionary.values.compactMap{ $0 }
    }
    
    func addCounter(counterItem: CounterItem) async throws {
        _ = try await db.save(counterItem.record)
        
    }
    
    func populateCounters() async throws {
        let query = CKQuery(recordType: CounterRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let result = try await db.records(matching: query)
        let records = result.matchResults.compactMap {
            try? $0.1.get()
        }
        
        records.forEach { record in
            countersDictionary[record.recordID] = CounterItem(record: record)
        }
    }
    
}
