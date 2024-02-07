//
//  CounterEditView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-25.
//

import SwiftUI

struct CounterEditView: View {
    @Binding var counter: CounterItem
    @State private var isDeleteConfirmationPresented = false
    let onUpdate: (CounterItem) -> Void
    let onDelete: (CounterItem) -> Void
    
    @EnvironmentObject private var model: Model
    
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Edit Counter")
                .font(.headline)
                .padding(.top, 25)
            VStack (spacing: 20){
                TextField("Counter Title", text: $counter.name)
                ColorPicker("Select Color", selection: $counter.color)
                HStack {
                    Button(action: {
                        print("Archive")
                    }) {
                        Label("Archive", systemImage: "archivebox.fill")
                    }
                    Spacer()
                }
                HStack {
                    Button(role: .destructive, action: {
                        isDeleteConfirmationPresented.toggle()
                    }) {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    Spacer()
                }
            }.padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(colorScheme == .dark ? .bgSecondary : .white)
                )
                .padding(20)
            Spacer()
            
            Button(action: {
                let counterItemToUpdate = counter
                onUpdate(counterItemToUpdate)
                presentationMode.wrappedValue.dismiss()
            }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .dark ? .bgSecondary : .black)
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
        .background(colorScheme == .dark ? .bgPrimary : .bgSecondary)
        .confirmationDialog("Delete Counter", isPresented: $isDeleteConfirmationPresented, actions: {
            Button("Delete", role: .destructive) {
                let counterItemToDelete = counter
                onDelete(counterItemToDelete)
                presentationMode.wrappedValue.dismiss()
            }
            
            Button("Cancel", role: .cancel) { }
        })

    }
}
