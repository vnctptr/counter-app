//
//  Counter.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-21.
//

import SwiftUI

struct Counter: Identifiable {
    var id: UUID = .init()
    var name: String
    var count: Int = 0    
}


var sampleCounters: [Counter] = [
    .init(name: "Books", count:1),
    .init(name: "Sold", count:15),
    .init(name: "Given away", count:200)
]
