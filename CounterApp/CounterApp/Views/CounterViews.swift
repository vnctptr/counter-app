//
//  CounterViews.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-24.
//

import SwiftUI

private func updateCounter(counterItem: CounterItem, model: Model) {
    
    Task {
        do {
            try await model.updateCounter(editedCounterItem: counterItem)
        } catch {
            print(error)
        }
    }
}


struct CounterList: View {
    @State private var selectedCounter: CounterItem?
    @EnvironmentObject private var model: Model

    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
//                ForEach(sampleCounters, id: \.recordId) { counter in
                ForEach(model.counters, id: \.recordId) { counter in
                    CounterItemView(counter: counter, onUpdate: updateCounter)
                        .padding(.horizontal, 25)
                        .onTapGesture {
                            selectedCounter = counter
                        }
                }
            }
            .task {
                do {
                    try await model.populateCounters()
                } catch {
                    print(error)
                }
            }
        }
        .sheet(item: $selectedCounter) { selectedCounter in
            CounterDetailSheetView(counter: selectedCounter, onUpdate: updateCounter)
                .presentationDetents([.medium])
                .presentationCornerRadius(30)
        }
    }
}

struct CounterDetailSheetView: View {
    @EnvironmentObject private var model: Model
    @Environment(\.colorScheme) var colorScheme
    
    @State var counter: CounterItem
    
    let onUpdate: (CounterItem, Model) -> Void
    
    private func updateCounter(counterItem: CounterItem) {
        Task {
            do {
                try await model.updateCounter(editedCounterItem: counterItem)
            } catch {
                print(error)
            }
        }
    }
    
    
    var body: some View {
        TabView {
            CounterDetailView(counter: counter, onUpdate: updateCounter)
                .tabItem() {
                    Image(systemName: "number.circle.fill")
                }
            CounterEditView(counter: counter, onUpdate: updateCounter)
                .tabItem() {
                    Image(systemName: "pencil")
                }
            
        }.accentColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct CounterItemView: View {
    @EnvironmentObject private var model: Model
    let counter: CounterItem
    let onUpdate: (CounterItem, Model) -> Void
    let TRUNCATED_NAME_LENGTH = 25
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(counter.color)
                .frame(height: 100)
            
            HStack(alignment: .lastTextBaseline) {
                Text(String(counter.count))
                    .font(.system(size: LARGE_TITLE))
                    .fontWeight(.semibold)
                let truncatedName = counter.name.prefix(TRUNCATED_NAME_LENGTH) + (counter.name.count > TRUNCATED_NAME_LENGTH ? "..." : "")
                Text(truncatedName)
                    .font(.title3)
                    .padding(.leading, 10)
                Spacer()
                CounterButton(imageName: "plus.circle.fill")
                    .onTapGesture {
                        var counterItemToUpdate = counter
                        counterItemToUpdate.count += 1
                        onUpdate(counterItemToUpdate, model)
                    }
                    .padding(10)
            }
            .padding(15)
        }
        .frame(maxWidth: 600)
    }
}

struct CounterButton: View {
    let imageName: String
    let fontSize: CGFloat?
    
    init(imageName: String, fontSize: CGFloat = LARGE_TITLE) {
        self.imageName = imageName
        self.fontSize = fontSize
    }
    
    var body: some View {
        Image(systemName: imageName).font(.system(size: CGFloat(fontSize ?? LARGE_TITLE)))
    }
}
