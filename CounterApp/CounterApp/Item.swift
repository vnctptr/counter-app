//
//  Item.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
