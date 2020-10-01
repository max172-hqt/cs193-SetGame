//
//  Diamond.swift
//  SetGame
//
//  Created by Huy Tran on 9/15/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        let top = CGPoint(x: center.x, y: center.y + radius)
        let right = CGPoint(x: center.x + radius, y: center.y)
        let left = CGPoint(x: center.x - radius, y: center.y)
        let bottom = CGPoint(x: center.x, y: center.y - radius)

        var p = Path()

        p.move(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        p.addLine(to: top)

        return p
    }
}
