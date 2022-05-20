//
//  AspectScrollVGrid.swift
//  SetCardGame
//
//  Created by Rajiv Keshav Balloo on 2022-05-19.
//

import SwiftUI

struct AspectScrollVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
        
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: [adaptiveGridItem()], spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
        }
    }
    
    private func adaptiveGridItem() -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: 70))
        gridItem.spacing = 0
        return gridItem
    }
}

//struct AspectScrollVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectScrollVGrid(aspectRatio: 2/3)
//    }
//}
