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
    
    func addCounter(counterItem: CounterItem) async throws {
        let record = try await db.save(counterItem.record)
        
    }
    
}
