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
            CounterList()
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Text("Category 1")                        
                    } label: {
                        HStack {
                            Text("All counters")
                            Image(systemName: "chevron.down")
                        }
                        
                        .foregroundColor( .black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
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

struct CounterList: View {
    let counters = sampleCounters
    var body: some View {
        
        VStack(spacing: 15) {
            ForEach(counters) { counter in
                CounterItem(counter: counter).padding(.horizontal, 25)
            }
        }
    }
}

struct CounterItem: View {
    let counter: Counter
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
                .frame(height: 100)
            HStack(alignment: .lastTextBaseline) {
                Text(String(counter.count)).font(.system(size: 50)).fontWeight(.semibold)
                Text(counter.name).font(.system(size: 20)).padding(.leading, 10)
                Spacer()
                PlusButton().padding(10)
            }
            .padding(15)
        }
    }
}

struct PlusButton: View {
    var body: some View {
        Image(systemName: "plus.circle.fill").font(.system(size: 50))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
