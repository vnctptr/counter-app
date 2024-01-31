//
//  ContentView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-17.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationSplitView {
            VStack {
                CounterList()
                Spacer()
            }
            .toolbar {
                //                TODO: Uncomment this when filters are added
                //                ToolbarItem(placement: .navigationBarLeading) {
                //                    Menu {
                //                        Button {
                //                            print("button pressed")
                //                        } label: {
                //                            Text("Category 1")
                //                        }
                //                    } label: {
                //                        HStack {
                //                            Text("All counters").foregroundColor(.black)
                //                            Image(systemName: "chevron.down")
                //                        }
                //                        .foregroundColor(.black)
                //                    }
                //                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                    }
                    
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
