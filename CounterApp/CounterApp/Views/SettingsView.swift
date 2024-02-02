//
//  SettingsView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-28.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.headline)
                .padding(.top, 25)
            VStack (spacing: 20){
                HStack {
                    Text("Donate")
                    Spacer()
                }
                HStack {
                    Text("Export")
                    Spacer()
                }
                HStack {
                    Text("Reset all")
                    Spacer()
                }
            }.padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(colorScheme == .dark ? Color.bgSecondary : Color.gray)
                ).padding(20)
            Spacer()
        }.background(colorScheme == .dark ? Color.bgPrimary : Color.white)
        
    }
}
