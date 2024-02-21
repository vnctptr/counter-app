//
//  CounterCreateView.swift
//  CounterApp
//
//  Created by Vincent Potrykus on 2024-01-30.
//

import SwiftUI

struct CounterCreateView: View {
    @State private var count = 0
    @State private var counterName: String = ""
    @State private var selectedColor = Color.coralAccent
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var model: Model
    
    var body: some View {
        VStack {
            Text("Create Counter")
                .font(.headline)
                .padding(.top, 25)
            VStack (spacing: 20){
                TextField("Counter Title", text: $counterName)
                ColorPicker("Select Color", selection: $selectedColor)
            }.padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(colorScheme == .dark ? .bgSecondary : .white)
                    
                ).padding(20)
            Spacer()
            
            let name = counterName == "" ? "Counter": counterName
            Button(action: {
                let counterItem = CounterItem(name: name, count: 0, color: selectedColor, archived: false)
                Task {
                    try await model.addCounter(counterItem: counterItem)
                }
                presentationMode.wrappedValue.dismiss()
            }
            ) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .dark ? Color.bgSecondary : Color.black)
                    .frame(height: 50)
                    .overlay(
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.headline)
                            Text("Add Counter")
                                .font(.headline)
                        }
                        
                    )
                    .foregroundColor(.white)
            }.padding(30)
            
        }.background(colorScheme == .dark ? Color.bgPrimary : Color.bgSecondary)
        
    }
        
}

func colorToHexString(color: UIColor) -> String {
    let components = color.cgColor.components
    let r: CGFloat = components?[0] ?? 0.0
    let g: CGFloat = components?[1] ?? 0.0
    let b: CGFloat = components?[2] ?? 0.0

    let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    return hexString
 }

func hexStringToColor(hexString: String) -> UIColor {
    var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

    let alpha: CGFloat = 1.0
    let red: CGFloat = colorComponentFrom(colorString: colorString, start: 0, length: 2)
    let green: CGFloat = colorComponentFrom(colorString: colorString, start: 2, length: 2)
    let blue: CGFloat = colorComponentFrom(colorString: colorString, start: 4, length: 2)

    let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    return color
}

func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

    let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
    let endIndex = colorString.index(startIndex, offsetBy: length)
    let subString = colorString[startIndex..<endIndex]
    let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
    var hexComponent: UInt64 = 0

    guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
        return 0
    }
    let hexFloat: CGFloat = CGFloat(hexComponent)
    let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
    return floatValue
}
