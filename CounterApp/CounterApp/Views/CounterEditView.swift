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
    @EnvironmentObject private var model: Model
    @Binding var counter: CounterItem
    let onUpdate: (CounterItem) -> Void
    @State private var isCreateHabitSheetPresented = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Edit Counter")
                .font(.headline)
                .padding(.top, 25)
            VStack (spacing: 20){
                TextField("Counter Title", text: $counter.name)
                ColorPicker("Select Color", selection: $counter.color)
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
                        .fill(colorScheme == .dark ? Color.textInputGrey : Color.white)
                )
                .padding(20)
            Spacer()
            
            Button(action: {
                let counterItemToUpdate = counter
                print(counterItemToUpdate.name)
                print(counter.name)
                onUpdate(counterItemToUpdate)
            }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .dark ? Color.bgSecondary : Color.gray)
                    .frame(height: 50)
                    .overlay(
                        HStack {
                            Text("Save Changes")
                                .font(.headline)
                        }
                        
                    )
                    .foregroundColor(.white)
            }.padding(30)
        }

    }
}
