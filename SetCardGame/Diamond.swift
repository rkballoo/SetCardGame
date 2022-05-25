//
//  Diamond.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-25.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let firstPoint = CGPoint(x: rect.midX, y: rect.minY)
        let secondPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let end = CGPoint(x: rect.midX, y: rect.maxY)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: firstPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: end)
        p.addLine(to: start)
        p.addLine(to: firstPoint)
        
        return p
    }
}

//struct Diamond_Previews: PreviewProvider {
//    static var previews: some View {
//        Diamond().stroke(.red, lineWidth: 10).frame(width: 300, height: 125, alignment: .center)
//    }
//}
