//
//  ContentView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-17.
//

import SwiftUI
import SwiftData


struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationSplitView {
            VStack {
                CounterList()
                Spacer()
            }.background(colorScheme == .dark ? Color(UIColor(red: 14.00 / 255.0, green: 14.00 / 255.0, blue: 15.00 / 255.0, alpha: 1.00)) : Color.white)
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: CounterCreateView()) {
                            Image(systemName: "plus").foregroundColor(Color.primary)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill").foregroundColor(Color.primary)
                        }
                    }
                }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView().environmentObject(Model())
    
}
