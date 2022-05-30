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
                TopMenu(game: game)
                AspectScrollVGrid(items: game.faceUpCards, aspectRatio: 2/3) { card in
                    CardView(card, color: game.getColor(card: card))
                        .padding(4)
                        .onTapGesture {
                            game.select(card)
                        }
                }
                BottomMenu(game: game, score: game.score)
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
    let score: Int
    
    var body: some View {
        HStack {
            Button(action: game.cheat) {
                Text("Help!")
            }
            .padding(.horizontal)
            Spacer()
            Text("Score: \(score)")
                .foregroundColor(Color("scoreColor"))
                .padding(.horizontal)
        }
    }
}

struct TopMenu: View {
    let game: ColoredSetGame
    
    var body: some View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ColoredSetGame()
        ColoredSetGameView(game: game)
    }
}
