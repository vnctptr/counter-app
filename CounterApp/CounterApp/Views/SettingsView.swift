//
//  SettingsView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-28.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {

        Color.gray.opacity(0.1)
            .edgesIgnoringSafeArea(.all)
            .overlay(
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
                                .fill(Color.white)
                        ).padding(20)
                Spacer()
                }

            )   }
}
