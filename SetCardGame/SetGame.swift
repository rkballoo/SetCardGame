//
//  SetGame.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import Foundation
import SwiftUI

struct SetGame {
    
    enum CardColor: CaseIterable {
        case firstColor, secondColor, thirdColor
    }
    enum Symbol: CaseIterable {
        case diamond, squiggle, oval
    }
    enum SymbolShading: CaseIterable {
        case solid, striped, open
    }
    enum NumberOfSymbols: Int, CaseIterable {
        case one = 1, two = 2, three = 3
    }
    
    var cardsInDeck: [Card]
    var faceUpCards: [Card] = []
    var matchedCards: [Card] = []
    var selectedCards: [Card] = [] // {
//        get {
//            ForEach(faceUpCards, id: ) { card in
//                if card.isSelected {
//
//                }
//            }
//        }
//    }
    
    mutating func drawCards(numberToDraw: Int) {
        if numberToDraw > cardsInDeck.count {
            return
        }
        for _ in 0..<numberToDraw {
            faceUpCards.append(cardsInDeck.removeFirst())
        }
    }
    
    mutating func select(_ card: Card) {
        if let selectedIndex = faceUpCards.firstIndex(where: {$0.id == card.id}),
           !faceUpCards[selectedIndex].isSelected,
           faceUpCards[selectedIndex].isMatched != true,
           selectedCards.count < 3
        {
            faceUpCards[selectedIndex].isSelected = true
        }
//        else if
    }
    
    init() {
        var cards = [Card]()
        var count = 0
        
        for color in CardColor.allCases {
            for symbol in Symbol.allCases {
                for shading in SymbolShading.allCases {
                    for number in NumberOfSymbols.allCases {
                        cards.append(
                            Card(
                                id: count,
                                color: color,
                                symbol: symbol,
                                shading: shading,
                                number: number
                            ))
                        count += 1
                    }
                }
            }
        }
        
        cardsInDeck = cards.shuffled()
    }
    
    struct Card: Identifiable {
        let id: Int
        let color: CardColor
        let symbol: Symbol
        let shading: SymbolShading
        let number: NumberOfSymbols
        
        var isFaceUp = false
        var isSelected = false
        var isMatched: Bool?
    }
}
