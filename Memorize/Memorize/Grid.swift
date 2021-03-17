//
//  Grid.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-05.
//  Copyright © 2021 Ahoo. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView){
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
        
    }
    
    private func body(for layout: GridLayout) -> some View{
        ForEach(self.items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return Group{ //because we only are returning in the if statement
            if index != nil {
                viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index)) //not usually alright to add ! to get the value of optional but in this case we must                                                    find the index and we dont then we want out program to crash
            }
        }
    }
    
    
    
}


