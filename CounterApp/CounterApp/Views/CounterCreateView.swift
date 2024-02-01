//
//  CounterCreateView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-30.
//

import SwiftUI

struct CounterCreateView: View {
    @State private var count = 0
    @State private var counterName: String = ""
    @State private var selectedColor = Color.blue
    @State private var itemTitle: String = ""
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var model = Model()
    
    var body: some View {
        
        Color.gray.opacity(0.1)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    Text("Create counter")
                        .font(.headline)
                        .padding(.top, 25)
                    VStack (spacing: 20){
                        TextField("Counter title", text: $counterName)
                        ColorPicker("Select Color", selection: $selectedColor)
                    }.padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(colorScheme == .dark ? Color(UIColor(red: 24.00 / 255.0, green: 24.00 / 255.0, blue: 25.00 / 255.0, alpha: 1.00)) : Color.white)
                            
                        ).padding(20)
                    Spacer()
                    
                    Button(action: {
                        let counterItem = CounterItem(name: counterName, count: 0)
                        Task {
                            try await model.addCounter(counterItem: counterItem)
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorScheme == .dark ? Color(UIColor(red: 24.00 / 255.0, green: 24.00 / 255.0, blue: 25.00 / 255.0, alpha: 1.00)) : Color.gray)
                            .frame(height: 50)
                            .overlay(
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.headline)
                                    Text("Add Counter")
                                        .font(.headline)
                                }
                                
                            )
                            .foregroundColor(.white)
                    }.padding(30)
                    
                }
                
            )   }
}
