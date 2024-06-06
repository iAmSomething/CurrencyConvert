//
//  SubViews.swift
//  currencyRate
//
//  Created by 김태훈 on 6/6/24.
//

import Foundation
import SwiftUI
struct CustomKeyboardView: View {
    @Binding var inputValue: String
    
    let keys: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["00", "0", "del"]
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {                
                ForEach(keys, id: \.self) { row in
                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                        ForEach(row, id: \.self) { key in
                            KeyView(key: key, action: { self.keyPressed(key) })
                                .frame(width: geometry.size.width / CGFloat(row.count), height: geometry.size.height / 2.0 / CGFloat(row.count))
                        }
                    }
                }
            }
        }
    }
    
    private func keyPressed(_ key: String) {
        switch key {
        case "del":
            if !inputValue.isEmpty {
                inputValue.removeLast()
            }
        case "00":
            inputValue.append("00")
        default:
            inputValue.append(key)
        }
        if let doubleValue = inputValue.doubleValue {
            inputValue = doubleValue.formattedString
        }
    }
}

struct KeyView: View {
    let key: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if key == "del" {
                Image(systemName: "delete.left")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            } else {
                Text(key)
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            }
        }
    }
}


/*
 struct CustomKeyboardView: View {
     let keys: [[String]] = [
         ["1", "2", "3"],
         ["4", "5", "6"],
         ["7", "8", "9"],
         ["00", "0", "del"]
     ]
     
     var body: some View {
         GeometryReader { geometry in
             VStack(spacing: 0) {
                 ForEach(keys, id: \.self) { row in
                     LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                         ForEach(row, id: \.self) { key in
                             KeyView(key: key)
                                 .frame(width: geometry.size.width / CGFloat(row.count), height: geometry.size.width / CGFloat(row.count))
                         }
                     }
                 }
             }
         }
     }
 }

 struct KeyView: View {
     let key: String
     
     var body: some View {
         if key == "del" {
             Image(systemName: "delete.left")
                 .font(.title)
                 .foregroundColor(.black)
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .background(Color.white)
         } else {
             Text(key)
                 .font(.title)
                 .foregroundColor(.black)
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .background(Color.white)
         }
     }
 }

 */
