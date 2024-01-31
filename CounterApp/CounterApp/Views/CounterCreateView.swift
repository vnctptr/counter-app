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
                            .onSubmit {
                                let counterItem = CounterItem(name: counterName, count: 0)
                                Task {
                                   try await model.addCounter(counterItem: counterItem)
                                }
                            }
                        ColorPicker("Select Color", selection: $selectedColor)
                        HStack {
                            Text("Archive")
                            Spacer()
                        }
                        HStack {
                            Text("Delete").foregroundColor(.red)
                            Spacer()
                        }
                    }.padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        ).padding(20)
                Spacer()
                }

            )   }
}
