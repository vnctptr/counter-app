//
//  CounterDetailView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-26.
//

import SwiftUI

struct CounterDetailView: View {
    @State var counter: CounterItem
    let onUpdate: (CounterItem) -> Void
    
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
            }.padding(.vertical, 20)
            Spacer()
        }
    }
    
}
