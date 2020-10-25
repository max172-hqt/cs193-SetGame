//
//  Cardify.swift
//  SetGame
//
//  Created by Huy Tran on 10/20/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isSelected: Bool
    var isMatched: Bool?
    
    init(isSelected: Bool, isMatched: Bool?) {
        self.isSelected = isSelected
        self.isMatched = isMatched
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            }

            Group {
                if isSelected {
                    if isMatched != nil {
                        if isMatched! {
                            RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.green, lineWidth: edgeLineWidth)
                        } else {
                            RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.red, lineWidth: edgeLineWidth)
                        }
                    } else {
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.yellow, lineWidth: edgeLineWidth)
                    }
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.black, lineWidth: edgeLineWidth)
                }
            }
        }
    }
    
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}


extension View {
    func cardify(isSelected: Bool, isMatched: Bool?) -> some View {
        self.modifier(Cardify(isSelected: isSelected, isMatched: isMatched))
    }
}

