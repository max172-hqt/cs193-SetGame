//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Huy Tran on 8/11/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
