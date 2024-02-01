//
//  CounterViews.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-24.
//

import SwiftUI


struct CounterList: View {
    @State private var selectedCounter: CounterItem?
    @StateObject private var model = Model()
    var body: some View {
        
        
        VStack(spacing: 15) {
            VStack {
                ForEach(model.counters, id: \.recordId) { counter in
                    CounterItemView(counter: counter).padding(.horizontal, 25)
                        .onTapGesture {
                            selectedCounter = counter
                        }
                }
            }
            .task {
                do {
                    try await model.populateCounters()
                }
                catch {
                    print(error)
                }
            }

        }.sheet(item: $selectedCounter) { selectedCounter in
            CounterDetailSheetView(counter: selectedCounter)
                .presentationDetents([.medium])
                .presentationCornerRadius(30)
        }
    }
}

struct CounterDetailSheetView: View {
    let counter: CounterItem
    
    var body: some View {
        TabView {
            CounterDetailView(counter: counter)
                .tabItem() {
                    Image(systemName: "number.circle.fill")
            }
            CounterEditView()
                .tabItem() {
                    Image(systemName: "pencil")
                }

        }.accentColor(.black)

    }
}

struct CounterItemView: View {
    let counter: CounterItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
                .frame(height: 100)
            HStack(alignment: .lastTextBaseline) {
                Text(String(counter.count)).font(.system(size: 50)).fontWeight(.semibold)
                Text(counter.name).font(.system(size: 20)).padding(.leading, 10)
                Spacer()
                CounterButton(imageName: "plus.circle.fill")
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
