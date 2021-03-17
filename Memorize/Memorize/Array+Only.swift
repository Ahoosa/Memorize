//
//  Array+Only.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-06.
//  Copyright © 2021 Ahoo. All rights reserved.
//

import Foundation

extension Array{
    var only: Element?{
        count == 1 ? first : nil
    }
}
