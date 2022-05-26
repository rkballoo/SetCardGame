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
    
    init(_ card: SetGame.Card, color: Color) {
        self.card = card
        self.color = color
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color("cardColor"))
//                shape.strokeBorder(.black, lineWidth: DrawingConstants.lineWidth)
                SymbolView(card: card, color: color, size: geometry.size)
                if card.isSelected {
                    switch card.isMatched {
                        case true:
                            shape.fill(.green).opacity(0.3)
                        case false:
                            shape.fill(.red).opacity(0.3)
                        default:
                            shape.fill(.blue).opacity(0.3)
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}
