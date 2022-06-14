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
            SymbolView(card: card, color: color, size: geometry.size)
                .cardify(
                    isFaceUp: card.isFaceUp,
                    isSelected: card.isSelected,
                    isMatched: card.isMatched,
                    highlighted: card.highlighted,
                    color: color,
                    colorBlindMode: colorBlindMode)
        }
    }
}
