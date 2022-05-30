//
//  CardView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    let color : Color
    let colorBlindMode: Bool
    
    init(_ card: SetGame.Card, color: Color, colorBlindMode: Bool) {
        self.card = card
        self.color = color
        self.colorBlindMode = colorBlindMode
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color("cardColor"))
                if card.highlighted == true {
                    shape.strokeBorder(.yellow.opacity(0.3), lineWidth: DrawingConstants.lineWidth)
                }
                SymbolView(card: card, color: color, size: geometry.size)
                if colorBlindMode {
                    VStack {
                        Spacer()
                        Text(color.description.capitalized)
                            .font(.caption)
                    }
                }
                if card.isSelected {
                    switch card.isMatched {
                        case true:
                            shape.fill(.green).opacity(0.3)
                            if colorBlindMode {
                                VStack {
                                    Text("Set!")
                                        .font(.caption)
                                    Spacer()
                                }
                            }
                        case false:
                            shape.fill(.red).opacity(0.3)
                            if colorBlindMode {
                                VStack {
                                    Text("Not A Set")
                                        .font(.caption2)
                                    Spacer()
                                }
                            }
                        default:
                            shape.fill(.blue).opacity(0.3)
                            if colorBlindMode {
                                VStack {
                                    Text("Selected")
                                        .font(.caption)
                                    Spacer()
                                }
                            }
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 5
    }
}
