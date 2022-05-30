//
//  SetCardGameApp.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

@main
struct SetCardGameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = ColoredSetGame()
            ColoredSetGameView(game: game).background(Color("backgroundColor"))
        }
    }
}
