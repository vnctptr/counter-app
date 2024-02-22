//
//  Model.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-30.
//

import Foundation
import CloudKit
import SwiftUI

@MainActor
class Model: ObservableObject {
    
    private var db = CKContainer.default().privateCloudDatabase
    @Published private var countersDictionary: [CKRecord.ID: CounterItem] = [:]
    
    var counters: [CounterItem] {
        countersDictionary.values.compactMap{ $0 }
    }
    
    func addCounter(counterItem: CounterItem) async throws {
        let record = try await db.save(counterItem.record)
        guard let counter = CounterItem(record: record) else { return }
        withAnimation {
            countersDictionary[counter.recordId!] = counter
        }
    }
    
    func deleteCounter(counterItem: CounterItem) async throws {
        guard let recordId = counterItem.recordId else { return }
        
        do {
            try await db.deleteRecord(withID: recordId)
            withAnimation {
                countersDictionary[recordId] = nil
            }
        } catch {
            print("Error deleting counter: \(error)")
            throw error
        }
    }
    
    func updateCounter(editedCounterItem: CounterItem) async throws {
        countersDictionary[editedCounterItem.recordId!]?.count = editedCounterItem.count
        countersDictionary[editedCounterItem.recordId!]?.name = editedCounterItem.name
        countersDictionary[editedCounterItem.recordId!]?.colorHex = editedCounterItem.colorHex
        countersDictionary[editedCounterItem.recordId!]?.archived = editedCounterItem.archived
        
        do {
            let record = try await db.record(for: editedCounterItem.recordId!)
            record[CounterRecordKeys.count.rawValue] = editedCounterItem.count
            record[CounterRecordKeys.name.rawValue] = editedCounterItem.name
            record[CounterRecordKeys.colorHex.rawValue] = editedCounterItem.colorHex
            record[CounterRecordKeys.archived.rawValue] = editedCounterItem.archived
            withAnimation {
                if (editedCounterItem.archived) {
                    countersDictionary[editedCounterItem.recordId!] = nil
                }
                
            }
            
            try await db.save(record)
        } catch {
            // TODO: throw an error to tell the user that something has happened and the update was not successful
            countersDictionary[editedCounterItem.recordId!] = editedCounterItem
        }
    }
    
    func populateCounters() async throws {
        let predicate = NSPredicate(format: "%K == %@", CounterRecordKeys.archived.rawValue, NSNumber(value: false))
        let query = CKQuery(recordType: CounterRecordKeys.type.rawValue, predicate: predicate)
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
