//
//  ContentView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-17.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationSplitView {
            VStack {
                CounterList()
                Spacer()
            }
            .toolbar {
                //                TODO: Uncomment this when filters are added
                //                ToolbarItem(placement: .navigationBarLeading) {
                //                    Menu {
                //                        Button {
                //                            print("button pressed")
                //                        } label: {
                //                            Text("Category 1")
                //                        }
                //                    } label: {
                //                        HStack {
                //                            Text("All counters").foregroundColor(.black)
                //                            Image(systemName: "chevron.down")
                //                        }
                //                        .foregroundColor(.black)
                //                    }
                //                }
                
                ToolbarItem {
                    NavigationLink(destination: CounterCreateView()) {
                        Image(systemName: "plus").foregroundColor(Color.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill").foregroundColor(Color.primary)
                    }
                    
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    


}


#Preview {
    ContentView()
        
}
