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
    
    var cards: [Card]
    var selectedCardsIndices: [Int] {
        get { cards.indices.filter({cards[$0].isSelected}) }
    }
    
    mutating func drawCards(numberToDraw: Int) {
        if numberToDraw > cards.filter({!$0.isFaceUp && $0.isMatched != true}).count {
            return
        }
        for _ in 0..<numberToDraw {
            guard let index = cards.firstIndex(where: {!$0.isFaceUp && $0.isMatched != true}) else { return }
            cards[index].isFaceUp = true
        }
    }
    
    mutating func select(_ card: Card) {
        if let selectedIndex = cards.firstIndex(where: {$0.id == card.id}) {
            
            if !cards[selectedIndex].isSelected {
                switch selectedCardsIndices.count {
                    case let x where x < 2:
                        cards[selectedIndex].isSelected = true
                    case 2:
                        if(isSelectedSetMatch(index: selectedIndex)) {
                            cards[selectedCardsIndices[0]].isMatched = true
                            cards[selectedCardsIndices[1]].isMatched = true
                            cards[selectedIndex].isSelected = true
                            cards[selectedIndex].isMatched = true
                        } else {
                            cards[selectedCardsIndices[0]].isMatched = false
                            cards[selectedCardsIndices[1]].isMatched = false
                            cards[selectedIndex].isSelected = true
                            cards[selectedIndex].isMatched = false
                        }
                    case 3:
                        resetSelection()
                        cards[selectedIndex].isSelected = true
                    default:
                        return
                }
            } else if cards[selectedIndex].isMatched == false {
                resetSelection()
                cards[selectedIndex].isSelected = true
            } else {
                switch selectedCardsIndices.count {
                    case 1,2:
                        cards[selectedIndex].isSelected = false
                    default:
                        return
                }
            }
        } else {
            return
        }
    }
    
    private mutating func resetSelection() {
        cards.indices.filter({cards[$0].isFaceUp}).forEach() { index in
            if let matched = cards[index].isMatched {
                if matched == true {
                    cards[index].isSelected = false
                    cards[index].isFaceUp = false
                    swapMatchedWithNewCard(index)
                } else {
                    cards[index].isMatched = nil
                    cards[index].isSelected = false
                }
            } else {
                cards[index].isSelected = false
            }
        }
    }
    
    private mutating func swapMatchedWithNewCard(_ matchedCardIndex: Int) {
        if let index = cards.firstIndex(where: {!$0.isFaceUp && $0.isMatched != true}) {
            cards[index].isFaceUp = true
            cards.swapAt(index, matchedCardIndex)
        } else {
            return
        }
    }
    
    private func isSelectedSetMatch(index: Int) -> Bool {
        let card1 = cards[index]
        let card2 = cards[selectedCardsIndices[0]]
        let card3 = cards[selectedCardsIndices[1]]
        
        if ((card1.color == card2.color && card2.color == card3.color)
            || (card1.color != card2.color && card2.color != card3.color && card1.color != card3.color)
        ) {
            if ((card1.symbol == card2.symbol && card2.symbol == card3.symbol)
                || (card1.symbol != card2.symbol && card2.symbol != card3.symbol && card1.symbol != card3.symbol)
            ) {
                if ((card1.shading == card2.shading && card2.shading == card3.shading)
                    || (card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading)
                ) {
                    if ((card1.number == card2.number && card2.number == card3.number)
                        || (card1.number != card2.number && card2.number != card3.number && card1.number != card3.number)
                    ) {
                        return true
                    }
                }
            }
        }
        return false
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
        
        self.cards = cards.shuffled()
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
