//
//  StripedView.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-20.
//

import SwiftUI

struct StripedView: View {
    let color: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<StripeConstants.numberOfStrips, id: \.self) { number in
                Color.clear
                color.frame(width: StripeConstants.lineWidth)
                if number == StripeConstants.numberOfStrips - 1 {
                    Color.clear
                }
            }
        }
    }
    
    private struct StripeConstants {
        static let lineWidth: CGFloat = 1
        static let widthDivisor = 4
        static let numberOfStrips = 12
    }
}
