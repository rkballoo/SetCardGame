//
//  CardView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI
// WIP
struct CardView: View {
    let isDealt: Bool
    let card: SetGame.Card
    let color : Color
    let colorBlindMode: Bool
    
    init(_ isDealt: Bool, _ card: SetGame.Card, color: Color, colorBlindMode: Bool) {
        self.isDealt = isDealt
        self.card = card
        self.color = color
        self.colorBlindMode = colorBlindMode
    }
    
    var body: some View {
        GeometryReader { geometry in
            SymbolView(card: card, color: color, size: geometry.size)
                .cardify(
                    isDealt: isDealt,
                    isFaceUp: card.isFaceUp,
                    isSelected: card.isSelected,
                    isMatched: card.isMatched,
                    highlighted: card.highlighted,
                    color: color,
                    colorBlindMode: colorBlindMode)
        }
    }
}
