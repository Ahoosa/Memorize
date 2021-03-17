//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-05.
//  Copyright © 2021 Ahoo. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? { //optional Int
        for index in 0..<self.count{
            if self[index].id==matching.id{
                return index
            }
        }
        return nil //since we have optional Int we can return nil
    }
    
}

