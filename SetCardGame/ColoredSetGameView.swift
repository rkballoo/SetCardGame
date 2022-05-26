//
//  ColoredSetGameView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

struct ColoredSetGameView: View {
    @StateObject var game: ColoredSetGame
    
    var body: some View {
        VStack {
            Text("SET")
                .font(.largeTitle)
            HStack {
                Button(action: game.newGame) {
                    Image(systemName: "sparkles.rectangle.stack.fill").font(.title)
                }
                .padding(.horizontal)
                Spacer()
                Text("Score: \(game.score)")
                Spacer()
                Button(action: game.drawThreeCards) {
                    ZStack {
                        Image(systemName: "rectangle.stack.badge.plus").font(.title)
                    }
                }.disabled(!game.cardsAreLeftInDeck)
                    .padding(.horizontal)
            }
            AspectScrollVGrid(items: game.faceUpCards, aspectRatio: 2/3) { card in
                CardView(card, color: game.getColor(card: card))
                    .padding(4)
                    .onTapGesture {
                        game.select(card)
                    }
            }
//            HStack {
//                Button(action: game.newGame) {
//                    Image(systemName: "sparkles.rectangle.stack.fill").font(.title)
//                }
//                .padding()
//                Spacer()
//                Button(action: game.drawThreeCards) {
//                    ZStack {
//                        Image(systemName: "rectangle.stack.badge.plus").font(.title)
//                    }
//                }.disabled(!game.cardsAreLeftInDeck)
//                    .padding()
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ColoredSetGame()
        ColoredSetGameView(game: game)
    }
}
