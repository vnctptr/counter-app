//
//  CounterEditView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-25.
//

import SwiftUI

struct CounterEditView: View {
    @State private var count = 0
    @State private var counterName = "Counter"
    @State private var selectedColor = Color.blue
    @State private var itemTitle: String = ""
    
    
    var body: some View {

        Color.gray.opacity(0.1)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    Text("Edit counter")
                        .font(.headline)
                        .padding(.top, 25)
                    VStack (spacing: 20){
                        TextField("Counter title", text: $itemTitle)
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
