//
//  CounterDetailView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-26.
//

import SwiftUI

struct CounterDetailView: View {
    @State var counter: CounterItem
    @State private var isEditSheetPresented = false

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    let onUpdate: (CounterItem) -> Void
    let onDelete: (CounterItem) -> Void
    
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Menu() {
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
                        let counterItemToDelete = counter
                        onDelete(counterItemToDelete)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Delete", systemImage: "trash.fill")
                    }

                } label: {
                    Image(systemName: "ellipsis.circle.fill").font(.system(size: MEDIUM_ICON))
                }.accentColor(colorScheme == .dark ? .white : .black)
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
                        counter.count = 0
                        let counterItemToUpdate = counter
                        onUpdate(counterItemToUpdate)
                    }
                CounterButton(imageName: "plus.circle.fill")
                    .onTapGesture {
                        counter.count += 1
                        let counterItemToUpdate = counter
                        onUpdate(counterItemToUpdate)
                    }
            }.sheet(isPresented: $isEditSheetPresented) {
                CounterEditView(counter: counter, onUpdate: onUpdate)
                    .presentationDetents([.large])
                    .presentationCornerRadius(30)
            }
            
            .padding(.vertical, 20)
            Spacer(minLength: 20)
        }
    }
    
}
