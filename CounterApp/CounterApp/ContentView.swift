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
        NavigationView {
            VStack {
                CounterList()
                Spacer()
            }.background(colorScheme == .dark ? Color.bgPrimary : Color.white)
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
        }.navigationViewStyle(StackNavigationViewStyle())

    }
}

#Preview {
    ContentView().environmentObject(Model())
    
}
