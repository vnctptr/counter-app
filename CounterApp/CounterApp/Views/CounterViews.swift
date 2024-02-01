//
//  CounterViews.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-24.
//

import SwiftUI


struct CounterList: View {
    @State private var selectedCounter: CounterItem?
    @EnvironmentObject private var model: Model
    
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
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(model.counters, id: \.recordId) { counter in
                    CounterItemView(counter: counter, onUpdate: updateCounter)
                ForEach(sampleCounters, id: \.recordId) { counter in
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
    
    let onUpdate: (CounterItem) -> Void
    
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
            CounterEditView()
                .tabItem() {
                    Image(systemName: "pencil")
                }
            
        }.accentColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct CounterItemView: View {
    let counter: CounterItem
    let onUpdate: (CounterItem) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.gray)
                .frame(height: 100)
            HStack(alignment: .lastTextBaseline) {
                Text(String(counter.count)).font(.system(size: 50)).fontWeight(.semibold)
                Text(counter.name).font(.system(size: 20)).padding(.leading, 10)
                Spacer()
                CounterButton(imageName: "plus.circle.fill")
                    .onTapGesture {
                        var counterItemToUpdate = counter
                        counterItemToUpdate.count += 1
                        onUpdate(counterItemToUpdate)
                    }
                    .padding(10)
            }
            .padding(15)
        }
    }
}

struct CounterButton: View {
    let imageName: String
    let fontSize: CGFloat?
    
    init(imageName: String, fontSize: CGFloat? = 50) {
        self.imageName = imageName
        self.fontSize = fontSize
    }
    
    var body: some View {
        Image(systemName: imageName).font(.system(size: fontSize ?? 50))
    }
}
