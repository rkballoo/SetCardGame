//
//  Cardify.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-06-09.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    let isSelected: Bool
    let isMatched: Bool?
    let highlighted: Bool
    let color : Color
    let colorBlindMode: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color("cardColor"))
                shape.strokeBorder(.black, lineWidth: 1)
                shape.strokeBorder(.yellow.opacity(highlighted ? 0.3: 0), lineWidth: DrawingConstants.lineWidth)
                content
                VStack {
                    Spacer()
                    Text(color.description.capitalized)
                        .font(.caption)
                }
                .opacity(colorBlindMode ? 1 : 0)
//                if colorBlindMode {
//                    VStack {
//                        Spacer()
//                        Text(color.description.capitalized)
//                            .font(.caption)
//                    }
//                }
                shape.fill(.green).opacity(isMatched == true && isSelected ? 0.3 : 0)
                shape.fill(.red).opacity(isMatched == false && isSelected ? 0.3 : 0)
                shape.fill(.blue).opacity(isMatched == nil && isSelected ? 0.3 : 0)
                
                ZStack {
                    VStack {
                        Text("Set!")
                            .font(.caption)
                        Spacer()
                    }
                    .opacity(colorBlindMode && isMatched == true && isSelected ? 1 : 0)
                    VStack {
                        Text("Not A Set")
                            .font(.caption2)
                        Spacer()
                    }
                    .opacity(colorBlindMode && isMatched == false && isSelected ? 1 : 0)
                    VStack {
                        Text("Selected")
                            .font(.caption)
                        Spacer()
                    }
                    .opacity(colorBlindMode && isMatched == nil && isSelected ? 1 : 0)
                }
//                if isSelected {
//                    switch isMatched {
//                        case true:
//                            if colorBlindMode {
//                                VStack {
//                                    Text("Set!")
//                                        .font(.caption)
//                                    Spacer()
//                                }
//                            }
//                        case false:
//                            if colorBlindMode {
//                                VStack {
//                                    Text("Not A Set")
//                                        .font(.caption2)
//                                    Spacer()
//                                }
//                            }
//                        default:
//                            if colorBlindMode {
//                                VStack {
//                                    Text("Selected")
//                                        .font(.caption)
//                                    Spacer()
//                                }
//                            }
//                    }
//                }
            } else {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color("cardColor"))
                shape.strokeBorder(.black, lineWidth: 1)
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 5
    }
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool?, highlighted: Bool, color: Color, colorBlindMode: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isMatched: isMatched, highlighted: highlighted, color: color, colorBlindMode: colorBlindMode))
    }
}