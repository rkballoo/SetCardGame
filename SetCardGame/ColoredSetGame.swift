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
        game = ColoredSetGame.createSetGame()
    }
    
    var faceUpCards: [Card] {
        return game.cards.filter({$0.isFaceUp})
    }
    
    var cardsAreLeftInDeck: Bool {
        return game.cards.filter({!$0.isFaceUp && $0.isMatched != true}).count != 0
    }
    
    var score: Int {
        return game.score
    }
    
    private static func createSetGame() -> SetGame {
        var game = SetGame()
        game.drawCards(numberToDraw: 12)
        return game
    }
    
    // MARK: - Intent(s)
    
    func newGame() {
        game = ColoredSetGame.createSetGame()
    }
    
    func drawThreeCards() {
        game.drawThreeCards()
    }
    
    func cheat() {
        game.highlightFirstPossibleMatch()
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
