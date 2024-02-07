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
    @State private var selectedColor = Color.coralAccent
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var model: Model
    
    var body: some View {
        VStack {
            Text("Create Counter")
                .font(.headline)
                .padding(.top, 25)
            VStack (spacing: 20){
                TextField("Counter Title", text: $counterName)
                ColorPicker("Select Color", selection: $selectedColor)
            }.padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(colorScheme == .dark ? .bgSecondary : .white)
                    
                ).padding(20)
            Spacer()
            
            Button(action: {
                let counterItem = CounterItem(name: counterName == "" ? "Counter": counterName, count: 0, color: selectedColor)
                Task {
                    try await model.addCounter(counterItem: counterItem)
                }
                presentationMode.wrappedValue.dismiss()
            }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .dark ? Color.bgSecondary : Color.black)
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
            
        }.background(colorScheme == .dark ? Color.bgPrimary : Color.bgSecondary)
        
    }
        
}
