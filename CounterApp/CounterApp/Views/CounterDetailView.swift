//
//  CounterDetailView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-26.
//

import SwiftUI

struct CounterDetailView: View {
    let counter: CounterItem
    var body: some View {
        
        VStack {
            Spacer()
            Text(String(counter.count))
                .font(.system(size: 100))
                .fontWeight(.semibold)
            Text(counter.name)
                .font(.system(size: 20))
                .padding(.leading, 10)
            HStack (spacing: 40){
                CounterButton(imageName: "minus.circle.fill")
                CounterButton(imageName: "gobackward")
                CounterButton(imageName: "plus.circle.fill")
            }.padding(.vertical, 20)
            Spacer()
        }	
    }
    
}
