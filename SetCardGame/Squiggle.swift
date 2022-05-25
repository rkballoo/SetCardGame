//
//  Squiggle.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-25.
//

import SwiftUI

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(
            x: SquiggleConstants.startXMultipier * rect.maxX,
            y: rect.midY)
        let firstPoint = CGPoint(
            x: rect.midX,
            y: SquiggleConstants.midYMuliplier * rect.maxY)
        let secondPoint = CGPoint(
            x: (1 - SquiggleConstants.startXMultipier) * rect.maxX,
            y: rect.midY)
        let thirdPoint = CGPoint(
            x: rect.midX,
            y: (1 - SquiggleConstants.midYMuliplier) * rect.maxY)
        
        var p = Path()
        p.move(to: start)
        p.addQuadCurve(to: firstPoint, control: CGPoint(
            x: SquiggleConstants.quadCurveControlXMultiplier * rect.maxX,
            y: SquiggleConstants.quadCurveControlYMultiplier * rect.maxY))
        p.addCurve(to: secondPoint,
                   control1: CGPoint(
                    x: SquiggleConstants.cubicCurveControlOneXMultiplier * rect.maxX,
                    y: SquiggleConstants.cubicCurveControlOneYMultiplier * rect.maxY),
                   control2: CGPoint(
                    x: SquiggleConstants.cubicCurveControlTwoXMultiplier * rect.maxX,
                    y: SquiggleConstants.cubicCurveControlTwoYMultiplier * rect.maxY))
        p.addQuadCurve(to: thirdPoint, control: CGPoint(
            x: (1 - SquiggleConstants.quadCurveControlXMultiplier) * rect.maxX,
            y: (1 - SquiggleConstants.quadCurveControlYMultiplier) * rect.maxY))
        p.addCurve(to: start,
                   control1: CGPoint(
                    x: (1 - SquiggleConstants.cubicCurveControlOneXMultiplier) * rect.maxX,
                    y: (1 - SquiggleConstants.cubicCurveControlOneYMultiplier) * rect.maxY),
                   control2: CGPoint(
                    x: (1 - SquiggleConstants.cubicCurveControlTwoXMultiplier) * rect.maxX,
                    y: (1 - SquiggleConstants.cubicCurveControlTwoYMultiplier) * rect.maxY))

        
        return p
    }
    
    private struct SquiggleConstants  {
        static let startXMultipier: CGFloat = 0.03
        static let midYMuliplier: CGFloat = 0.18
        
        static let quadCurveControlXMultiplier: CGFloat = 0.05
        static let quadCurveControlYMultiplier: CGFloat = -0.15
        
        static let cubicCurveControlOneXMultiplier: CGFloat = 0.8
        static let cubicCurveControlOneYMultiplier: CGFloat = 0.5
        static let cubicCurveControlTwoXMultiplier: CGFloat = 1.04
        static let cubicCurveControlTwoYMultiplier: CGFloat = -0.55
    }
}

//struct Squiggle_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Rectangle().frame(width: 300, height: 125, alignment: .center)
//            Squiggle().stroke(.red, lineWidth: 3).frame(width: 300, height: 125, alignment: .center)
//        }
//    }
//}
