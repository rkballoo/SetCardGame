//
//  SymbolView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

struct SymbolView: View {
    let card: SetGame.Card
    let color: Color
    let size: CGSize
    
    var body: some View {
        VStack {
            Spacer()
            switch card.number {
                case .one:
                    symbolToUse()
                case .two:
                    symbolToUse()
                    symbolToUse()
                default:
                    symbolToUse()
                    symbolToUse()
                    symbolToUse()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func symbolToUse() -> some View {
        let width = size.width * SymbolConstants.relativeWidthMultiplier
        let height = size.height * SymbolConstants.relativeHeightMultiplier
        
        ZStack {
            let diamondBorder = Diamond().stroke(color, lineWidth: SymbolConstants.borderWidth).frame(width: width, height: height)
            let ovalBorder = Capsule().stroke(color, lineWidth: SymbolConstants.borderWidth).frame(width: width, height: height)
            let squiggleBorder = Squiggle().stroke(color, lineWidth: SymbolConstants.borderWidth).frame(width: width, height: height)
            
            let diamond = Diamond().frame(width: width, height: height)
            let oval = Capsule().frame(width: width, height: height)
            let squiggle = Squiggle().frame(width: width, height: height)
            
            switch card.symbol {
                case .diamond:
                    diamondBorder
                    shadingToUse(width: width,height: height).mask(diamond)
                case .oval:
                    ovalBorder
                    shadingToUse(width: width,height: height).mask(oval)
                default:
                    squiggleBorder
                    shadingToUse(width: width,height: height).mask(squiggle)
            }
        }
    }
    
    @ViewBuilder
    private func shadingToUse(width: CGFloat, height: CGFloat) -> some View {
        switch card.shading {
            case .solid:
                color.frame(width: width, height: height)
            case .striped:
                StripedView(width: width, height: height, color: color)
            default:
                Color("cardColor").frame(width: width, height: height)
        }
    }
    
    private struct SymbolConstants {
        static let relativeWidthMultiplier: CGFloat = 0.65
        static let relativeHeightMultiplier: CGFloat = 0.15
        static let borderWidth: CGFloat = 3
    }
}
