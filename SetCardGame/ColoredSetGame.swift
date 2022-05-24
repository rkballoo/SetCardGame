//
//  ColoredSetGame.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

class ColoredSetGame: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var game: SetGame
    
    init() {
        game = SetGame()
    }
    
    var faceUpCards: [Card] {
        return game.cards.filter({$0.isFaceUp})
    }
    
    var cardsInDeck: [Card] {
        return game.cards
    }
    
    // MARK: - Intent(s)
    
    func drawCards(numberToDraw: Int) {
        game.drawCards(numberToDraw: numberToDraw)
    }
    
    func drawThreeCards() {
        game.drawCards(numberToDraw: 3)
    }
    
    func select(_ card: Card) {
        game.select(card)
    }
    
    func getColor(card: Card) -> Color {
        switch card.color {
            case .firstColor:
                return Color.green
            case .secondColor:
                return Color.purple
            default:
                return Color.red
        }
    }
}
