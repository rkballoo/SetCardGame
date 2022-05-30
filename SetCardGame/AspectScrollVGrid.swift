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
                let width = widthThatFits(itemsCount: items.count, in: geometry.size)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemsCount: Int, in size: CGSize) -> CGFloat {
        var columnCount = 1
        var rowCount = itemsCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / CGFloat(aspectRatio)
            if itemHeight * CGFloat(rowCount) < size.height { break }
            columnCount += 1
            rowCount = (itemsCount / columnCount) + 1
        } while columnCount < itemsCount
        if columnCount > itemsCount {
            columnCount = itemsCount
        }
        
        let width: CGFloat = floor(size.width / CGFloat(columnCount))
        
        return max(60, width)
    }
}

//struct AspectScrollVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectScrollVGrid(aspectRatio: 2/3)
//    }
//}
