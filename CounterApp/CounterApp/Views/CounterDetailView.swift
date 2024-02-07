//
//  CounterDetailView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-26.
//

import SwiftUI

struct CounterDetailView: View {
    @State var counter: CounterItem
    @State private var isResetConfirmationPresented = false
    @Environment(\.colorScheme) var colorScheme

    let onUpdate: (CounterItem) -> Void
    let onDelete: (CounterItem) -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                CounterDetailMenuView(counter: $counter, onUpdate: onUpdate, onDelete: onDelete)
            }
            .padding(.top, 30)
            .padding(.trailing, 30)
            Spacer()
            Text(String(counter.count))
                .font(.system(size: EXTRA_LARGE_TITLE))
                .fontWeight(.semibold)
            Text(counter.name)
                .font(.title3)
                .padding(.leading, 10)
            HStack (spacing: 40){
                CounterButton(imageName: "minus.circle.fill")
                    .onTapGesture {
                        counter.count -= 1
                        let counterItemToUpdate = counter
                        // TODO: throw and catch error if onUpdate fails
                        onUpdate(counterItemToUpdate)
                    }
                CounterButton(imageName: "gobackward")
                    .onTapGesture {
                        //                    TODO: get confirmation from user to reset
                        isResetConfirmationPresented.toggle()
                    }
                    .confirmationDialog("Reset Counter", isPresented: $isResetConfirmationPresented, actions: {
                        Button("Reset", role: .destructive) {
                            counter.count = 0
                            let counterItemToDelete = counter
                            onUpdate(counterItemToDelete)
                        }
                        
                        Button("Cancel", role: .cancel) { }
                    })
                CounterButton(imageName: "plus.circle.fill")
                    .onTapGesture {
                        counter.count += 1
                        let counterItemToUpdate = counter
                        onUpdate(counterItemToUpdate)
                    }
            }
            
            .padding(.vertical, 20)
            Spacer(minLength: 20)
        }
    }
    
}

struct CounterDetailMenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State private var isEditSheetPresented = false
    @State private var isDeleteConfirmationPresented = false
    
    @Binding var counter: CounterItem
    let onUpdate: (CounterItem) -> Void
    let onDelete: (CounterItem) -> Void
    
    var body: some View {
        Menu {
            Button(action: {
                print("Edit")
                isEditSheetPresented.toggle()
            }) {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(action: {
                print("Archive")
            }) {
                Label("Archive", systemImage: "archivebox.fill")
            }
            
            Button(role: .destructive, action: {
                isDeleteConfirmationPresented.toggle()
            }) {
                Label("Delete", systemImage: "trash.fill")
            }
        } label: {
            Image(systemName: "ellipsis.circle.fill").font(.system(size: MEDIUM_ICON))
        }
        .accentColor(colorScheme == .dark ? .white : .black)
        .sheet(isPresented: $isEditSheetPresented) {
            CounterEditView(counter: $counter, onUpdate: onUpdate, onDelete: onDelete)
                .presentationDetents([.large])
                .presentationCornerRadius(30)
        }
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
