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
            AspectScrollVGrid(items: game.faceUpCards, aspectRatio: 2/3) { card in
                CardView(card, color: game.getColor(card: card))
                    .padding(4)
                    .onTapGesture {
                        game.select(card)
                    }
            }
            Button(action: game.drawThreeCards) {
                HStack(spacing: 0) {
                    Image(systemName: "plus").font(.title)
                    Image(systemName: "3.square.fill").font(.largeTitle)
                }
            }.disabled(!game.cardsAreLeftInDeck)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ColoredSetGame()
        ColoredSetGameView(game: game)
    }
}
