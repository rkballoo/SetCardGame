//
//  Cardify.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-06-09.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    let isSelected: Bool
    let isMatched: Bool?
    let highlighted: Bool
    let color : Color
    let colorBlindMode: Bool
    
    init(isFaceUp: Bool, isSelected: Bool, isMatched: Bool?, highlighted: Bool, color: Color, colorBlindMode: Bool) {
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.highlighted = highlighted
        self.color = color
        self.colorBlindMode = colorBlindMode
        
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            if rotation < 90 {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color("cardColor"))
                shape.strokeBorder(.black, lineWidth: 1)
                
                shape.strokeBorder(.yellow.opacity(highlighted ? 0.3: 0), lineWidth: DrawingConstants.lineWidth)
                
                content
                    .scaleEffect(isMatched == true && isSelected ? 1.1 : 1)
                    .animation(.spring().repeatForever(), value: isMatched)
                    .scaleEffect(isMatched == false && isSelected ? 0.8 : 1)
                
                VStack {
                    Spacer()
                    Text(color.description.capitalized)
                        .font(.caption)
                }
                .opacity(colorBlindMode ? 1 : 0)
                
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
            } else {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color("cardColor"))
                shape.strokeBorder(.black, lineWidth: 1)
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
