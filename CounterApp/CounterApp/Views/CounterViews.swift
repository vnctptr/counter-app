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
    let TRUNCATED_NAME_LENGTH = 23
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(hexStringToColor(hexString: counter.colorHex)))
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
                CounterButton(imageName: "plus.circle.fill", bgColor: hexStringToColor(hexString: counter.colorHex))
                    .onTapGesture {
                        var counterItemToUpdate = counter
                        counterItemToUpdate.count += 1
                        onUpdate(counterItemToUpdate, model)
                    }
                    .padding(15)
            }
            .padding(15)
        }
        .frame(maxWidth: 600)
    }
}

struct CounterButton: View {
    let imageName: String
    let bgColor: UIColor?
    let fontSize: CGFloat?

    init(imageName: String, bgColor: UIColor? = nil, fontSize: CGFloat? = nil) {
        self.imageName = imageName
        self.bgColor = bgColor
        self.fontSize = fontSize
    }

    var body: some View {
        let textColor = calculateTextColor(from: bgColor)
        return Image(systemName: imageName)
            .foregroundColor(textColor)
            .font(.system(size: CGFloat(fontSize ?? LARGE_TITLE)))
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
}
