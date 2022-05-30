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
            ScoreInBackground(game: game)
            VStack {
                Text("SET")
                    .font(.largeTitle)
                Spacer()
                TopMenu(game: game, score: game.score)
                AspectScrollVGrid(items: game.faceUpCards, aspectRatio: 2/3) { card in
                    CardView(card, color: game.getColor(card: card), colorBlindMode: game.colorBlindMode)
                        .padding(4)
                        .onTapGesture {
                            game.select(card)
                        }
                }
                BottomMenu(game: game)
            }
        }
    }
}

struct ScoreInBackground: View {
    let game: ColoredSetGame
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(game.score)")
                .font(.system(size: 80))
                .foregroundColor(Color("scoreColor"))
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct BottomMenu: View {
    let game: ColoredSetGame
    
    var body: some View {
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
}

struct TopMenu: View {
    let game: ColoredSetGame
    let score: Int
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
            Button(action: game.newGame) {
                Text("New Game")
            }
            Text("Score: \(score)")
                .foregroundColor(Color("scoreColor"))
            Button(action: game.drawThreeCards) {
                Text("+3 Cards")
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
