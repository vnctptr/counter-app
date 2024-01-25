//
//  CounterViews.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-24.
//

import SwiftUI


struct CounterList: View {
    let counters = sampleCounters
    @State private var selectedItem: Counter?
    var body: some View {
        
        VStack(spacing: 15) {
            ForEach(counters) { counter in
                CounterItem(counter: counter).padding(.horizontal, 25)
                    .onTapGesture {
                        selectedItem = counter
                    }
            }
        }.sheet(item: $selectedItem) { selectedCounter in
            CounterDetailView(item: selectedCounter)
                .presentationDetents([.medium])
                .presentationCornerRadius(30)
        }
    }
}


struct CounterDetailView: View {
    let item: Counter
    var body: some View {
        Text(item.name)
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
