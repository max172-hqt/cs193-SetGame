//
//  Array+Hashable.swift
//  SetGame
//
//  Created by Huy Tran on 9/20/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var formedASet: Bool {
        return Array(Set(self)).count == 1 ||
            Array(Set(self)).count == self.count
    }
}
