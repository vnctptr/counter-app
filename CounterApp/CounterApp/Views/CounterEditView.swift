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
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        
        Color(UIColor(red: 28.00 / 255.0, green: 28.00 / 255.0, blue: 30.00 / 255.0, alpha: 1.00))
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    Text("Edit Counter")
                        .font(.headline)
                        .padding(.top, 25)
                    VStack (spacing: 20){
                        TextField("Counter Title", text: $itemTitle)
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
                                .fill(colorScheme == .dark ? Color.bgSecondary : Color.white)                        ).padding(20)
                    Spacer()
                }
                
            )
    }
}
