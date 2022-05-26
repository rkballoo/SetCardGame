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
        ZStack {
            VStack {
                Spacer()
                Text("\(game.score)")
                    .font(.system(size: 80))
                    .foregroundColor(Color("scoreColor"))
                    .multilineTextAlignment(.center)
            }
            VStack {
                Text("SET")
                    .font(.largeTitle)
                Spacer()

                HStack {
                    Button(action: game.newGame) {
                        Text("New Game")
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button(action: game.drawThreeCards) {
                        Text("+3 Cards")
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
                HStack {
                    Button(action: game.cheat) {
                        Text("Help!")
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ColoredSetGame()
        ColoredSetGameView(game: game)
    }
}
