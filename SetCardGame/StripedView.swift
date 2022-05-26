//
//  StripedView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-20.
//

import SwiftUI

struct StripedView: View {
    let width: CGFloat
    let height: CGFloat
    let numberOfStrips: Int
    let color: Color
    
    init(width: CGFloat, height: CGFloat, color: Color) {
        self.width = width
        self.height = height
        self.color = color
        
        numberOfStrips = Int(width) / StripsConstants.widthDivisor
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numberOfStrips, id: \.self) { number in
                Color.white.opacity(0)
                color.frame(width: StripsConstants.lineWidth)
                if number == numberOfStrips - 1 {
                    Color.white.opacity(0)
                }
            }
            
        }.frame(width: width, height: height)
        
    }
    
    private struct StripsConstants {
        static let lineWidth: CGFloat = 1
        static let widthDivisor = 4
    }
}
