//
//  ColoredSetGameView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

struct ColoredSetGameView: View {
    @StateObject var game: ColoredSetGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack {
            VStack {
                Text("SET")
                    .font(.largeTitle)
                Spacer()
                topMenu
                gameBody
                HStack {
                    deckBody
                    Spacer()
                    discardBody
                }
                .padding(.horizontal)
                bottomMenu
            }
        }
    }
    
    @State private var dealt = Set<Int>()
    @State private var discarded = Set<Int>()
    
    private func deal(_ card: ColoredSetGame.Card) {
        dealt.insert(card.id)
    }
    
    private func discard(_ card: ColoredSetGame.Card) {
        discarded.insert(card.id)
    }
    
    private func discardCards() {
        for card in game.cards.filter( { $0.isMatched == true && !isDiscarded($0) } ) {
            discard(card)
        }
    }
    
    private func isDealt(_ card: ColoredSetGame.Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private func isDiscarded(_ card: ColoredSetGame.Card) -> Bool {
        discarded.contains(card.id)
    }
    
    private func zIndex(of card: ColoredSetGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func cardRotation(_ card: ColoredSetGame.Card) -> Double {
        let x = (Double(card.id) * CardConstants.rotationConstant).remainder(dividingBy: CardConstants.rotationDivisor)
        if card.id % 2 == 0 {
            return x * -5
        } else {
            return x * 5
        }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter( { !isDealt($0) })) { card in
                CardView(card, color: game.getColor(card: card), colorBlindMode: game.colorBlindMode)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .rotationEffect(Angle(degrees: cardRotation(card)))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
        .onTapGesture {
            if dealt.isEmpty {
                withAnimation {
                    game.drawTwelveCards()
                }
                for card in game.faceUpCards {
                    withAnimation {
                        deal(card)
                    }
                }
                
            } else {
                withAnimation {
                    discardCards()
                    game.drawThreeCards()
                }
                for card in game.faceUpCards.filter( { !isDealt($0) } ) {
                    withAnimation {
                        deal(card)
                    }
                }
            }
        }
    }
    
    var discardBody: some View {
        ZStack {
            ForEach(game.cards.filter( { isDiscarded($0) } )) { card in
                withAnimation {
                    CardView(card, color: game.getColor(card: card), colorBlindMode: game.colorBlindMode)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .rotationEffect(Angle(degrees: cardRotation(card)))
                }
            }
        }
        .frame(width: CardConstants.deckWidth, height: CardConstants.deckHeight)
    }
    
    var gameBody: some View {
        AspectScrollVGrid(items: game.faceUpCards, aspectRatio: CardConstants.aspectRatio) { card in
            if isDealt(card) && !isDiscarded(card) {
                withAnimation {
                    CardView(card, color: game.getColor(card: card), colorBlindMode: game.colorBlindMode)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(CardConstants.cardPadding)
                        .onTapGesture {
                            withAnimation {
                                discardCards()
                                game.select(card)
                                
                            }
                        }
                }
            }
        }
    }
    
    var topMenu: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            Button("New Game") {
                withAnimation {
                    dealt = []
                    discarded = []
                    game.newGame()
                }
            }
            Spacer()
            Text("Score: \(game.score)")
                .foregroundColor(Color("scoreColor"))
//            Button(action: game.drawThreeCards) {
//                Text("+3 Cards")
//            }.disabled(!game.cardsAreLeftInDeck)
        }
    }
    
    var bottomMenu: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()),  GridItem(.flexible())]) {
            Button(action: game.cheat) {
                Text("Help!")
            }
            Spacer()
            Button(action: game.colorBlindModeToggle) {
                Text("Col. Blind")
            }
        }
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let cardPadding: CGFloat = 4
        static let deckWidth: CGFloat = deckHeight * aspectRatio
        static let deckHeight: CGFloat = 90
        static let rotationConstant: Double = 13
        static let rotationDivisor: Double = 3
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ColoredSetGame()
        ColoredSetGameView(game: game)
    }
}
