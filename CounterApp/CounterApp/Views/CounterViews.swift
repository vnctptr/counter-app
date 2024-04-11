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
            .padding(.top, 5)
        }
        .sheet(item: $selectedCounter) { selectedCounter in
            CounterDetailSheetView(counter: selectedCounter, onUpdate: updateCounter)
                .presentationDetents([.height(500)])
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
    
    private func deleteCounter(counterItem: CounterItem) {
        Task {
            do {
                try await model.deleteCounter(counterItem: counterItem)
            } catch {
                print(error)
            }
        }
    }
    
    
    var body: some View {
        CounterDetailView(counter: counter, onUpdate: updateCounter, onDelete: deleteCounter)
    }
}

struct CounterItemView: View {
    @EnvironmentObject private var model: Model
    let counter: CounterItem
    let onUpdate: (CounterItem, Model) -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hexStringToColor(hexString: counter.colorHex)))
                .frame(height: 100)
            
            HStack(alignment: .lastTextBaseline) {
                let numOfDigits = String(counter.count).count
                let width = numOfDigits * 26 + 17
                let truncatedNameLength = 40 - (numOfDigits-1) * 6
                let truncatedName = counter.name.prefix(truncatedNameLength) + (counter.name.count > truncatedNameLength ? "..." : "")
                let foregroundColor = calculateTextColor(from: hexStringToColor(hexString: counter.colorHex))

                Rectangle()
                    .frame(width: CGFloat(width), height: 50)
                    .foregroundColor(Color.white.opacity(0))
                    .overlay(
                Text(String(counter.count))
                    .font(.system(size: LARGE_TITLE))
                    .fontWeight(.semibold)
                    .padding(.leading, 5)
                    .foregroundColor(foregroundColor),
                alignment: .topLeading)
                Text(truncatedName)
                    .font(.title3)
                    .padding(.leading, 10)
                    .foregroundColor(foregroundColor)
                Spacer()
                CounterButton(imageName: "plus.circle.fill", color: foregroundColor)
                    .onTapGesture {
                        var counterItemToUpdate = counter
                        counterItemToUpdate.count += 1
                        onUpdate(counterItemToUpdate, model)
                    }
                    .padding(15)
            }
            .padding(10)
        }
        .frame(maxWidth: 600)
    }
}

struct CounterButton: View {
    let imageName: String
    let color: Color?
    let fontSize: CGFloat?

    init(imageName: String, color: Color? = nil, fontSize: CGFloat? = nil) {
        self.imageName = imageName
        self.color = color
        self.fontSize = fontSize
    }

    var body: some View {
        return Image(systemName: imageName)
            .foregroundColor(color)
            .font(.system(size: CGFloat(fontSize ?? LARGE_TITLE)))
    }

}

private func calculateTextColor(from color: UIColor?) -> Color {
    guard let color = color else {
        return .white
    }

    guard let components = color.cgColor.components, components.count >= 3 else {
        return .white
    }

    let red = components[0] * 255
    let green = components[1] * 255
    let blue = components[2] * 255
    let brightness = (red * 0.299 + green * 0.587 + blue * 0.114)

    return brightness > 186 ? .black : .white
}
