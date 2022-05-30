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
    var score = 0
    private var selectedCardsIndices: [Int] {
        get { cards.indices.filter({cards[$0].isSelected}) }
    }
    
    mutating func drawCards(numberToDraw: Int) {
        if numberToDraw > cards.filter({!$0.isFaceUp && $0.isMatched != true}).count {
            return
        }
        
        if selectedCardsIndices.count == 3, cards[selectedCardsIndices[0]].isMatched == true {
            selectedCardsIndices.forEach() { index in
                swapMatchedWithNewCard(index)
            }
            return
        }
        
        for _ in 0..<numberToDraw {
            guard let index = cards.firstIndex(where: {!$0.isFaceUp && $0.isMatched != true}) else { return }
            cards[index].isFaceUp = true
        }
    }
    
    mutating func drawThreeCards() {
        if let _ = firstPossibleMatch() {
            if selectedCardsIndices.count == 3 && cards[selectedCardsIndices[0]].isMatched == true {
                score -= 3
            }
        }
        resetHighlight()
        drawCards(numberToDraw: 3)
    }
    
    mutating func select(_ card: Card) {
        if let selectedIndex = cards.firstIndex(where: {$0.id == card.id}) {
            resetHighlight()
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
                            score += getScore(cards: [cards[selectedCardsIndices[0]], cards[selectedCardsIndices[1]], cards[selectedIndex]])
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
    
    mutating func highlightFirstPossibleMatch() {
        resetHighlight()
        if let indices = firstPossibleMatch() {
            for index in indices {
                cards[index].highlighted = true
            }
        }
    }
    
    private mutating func resetHighlight() {
        cards.indices.filter({cards[$0].isFaceUp}).forEach() { index in
            if cards[index].highlighted == true { cards[index].highlighted = false }
        }
    }
    
    private mutating func resetSelection() {
        cards.indices.filter({cards[$0].isFaceUp}).forEach() { index in
            if let matched = cards[index].isMatched {
                if matched == true {
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
        cards[matchedCardIndex].isSelected = false
        cards[matchedCardIndex].isFaceUp = false
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

        return isSetMatch(cards: [card1, card2, card3])
    }
    
    private func isSetMatch(cards: [Card]) -> Bool {
        if ((cards[0].color == cards[1].color && cards[1].color == cards[2].color)
            || (cards[0].color != cards[1].color && cards[1].color != cards[2].color && cards[0].color != cards[2].color)
        ) {
            if ((cards[0].symbol == cards[1].symbol && cards[1].symbol == cards[2].symbol)
                || (cards[0].symbol != cards[1].symbol && cards[1].symbol != cards[2].symbol && cards[0].symbol != cards[2].symbol)
            ) {
                if ((cards[0].shading == cards[1].shading && cards[1].shading == cards[2].shading)
                    || (cards[0].shading != cards[1].shading && cards[1].shading != cards[2].shading && cards[0].shading != cards[2].shading)
                ) {
                    if ((cards[0].number == cards[1].number && cards[1].number == cards[2].number)
                        || (cards[0].number != cards[1].number && cards[1].number != cards[2].number && cards[0].number != cards[2].number)
                    ) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func firstPossibleMatch() -> [Int]? {
        let faceUpCards = cards.filter({$0.isFaceUp && $0.isMatched != true})
        
        for card1 in faceUpCards {
            for card2 in faceUpCards {
                if card1.id != card2.id {
                    let card3Id = idOfCardToCompleteSet(card1, card2)
                    let card3 = cards.filter({$0.id == card3Id})[0]
                    if card3.isFaceUp && card3.isMatched != true {
                        return cards.indices.filter({cards[$0].id == card1.id || cards[$0].id == card2.id || cards[$0].id == card3.id})
                    }
                }
            }
        }
        
        return nil
    }
    
    private func idOfCardToCompleteSet(_ card1: Card, _ card2: Card) -> Int {
        var color: CardColor
        var symbol: Symbol
        var shading: SymbolShading
        var number: NumberOfSymbols
        
        if card1.color == card2.color {
            color = card1.color
        } else {
            color = CardColor.allCases.filter({$0 != card1.color && $0 != card2.color})[0]
        }
        if card1.symbol == card2.symbol {
            symbol = card1.symbol
        } else {
            symbol = Symbol.allCases.filter({$0 != card1.symbol && $0 != card2.symbol})[0]
        }
        if card1.shading == card2.shading {
            shading = card1.shading
        } else {
            shading = SymbolShading.allCases.filter({$0 != card1.shading && $0 != card2.shading})[0]
        }
        if card1.number == card2.number {
            number = card1.number
        } else {
            number = NumberOfSymbols.allCases.filter({$0 != card1.number && $0 != card2.number})[0]
        }
        
        return cards.filter({$0.color == color && $0.symbol == symbol && $0.shading == shading && $0.number == number})[0].id
    }
    
    private func getScore(cards: [Card]) -> Int {
        var score = 0
        for card in cards {
            if let time = card.timeSinceFaceUp {
                score += max(2, 25 + Int(time.timeIntervalSinceNow))
            }
        }
        return score
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
        
        var isFaceUp = false {
            willSet {
                timeSinceFaceUp = Date()
            }
        }
        var isSelected = false
        var isMatched: Bool?
        var timeSinceFaceUp: Date?
        var highlighted: Bool = false
    }
}
