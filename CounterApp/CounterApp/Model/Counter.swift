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

