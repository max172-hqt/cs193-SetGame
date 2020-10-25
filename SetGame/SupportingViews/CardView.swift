//
//  CardView.swift
//  SetGame
//
//  Created by Huy Tran on 9/15/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: SetGameModel.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    // MARK: - Drawing main card content
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.inGame {
            ZStack {
                self.cardContent(size: size)
                    .rotationEffect(Angle.degrees(card.isMatched != nil && card.isMatched! ? 360 : 0))
                    .animation(card.isMatched != nil && card.isMatched! ? Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false) : .linear(duration: self.animationDuration))
                    .cardify(isSelected: card.isSelected, isMatched: card.isMatched)
            }
        }
    }
    
    // MARK: - Helpers: Drawing card content shape
    
    var cardColor: Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    @ViewBuilder
    private func cardContent(size: CGSize) -> some View {
        VStack {
            ForEach(1...self.card.number.rawValue, id: \.self) { num in
                Group {
                    if self.card.shape == .diamond {
                        if self.card.shading == .open {
                            Diamond()
                                .stroke(self.cardColor, lineWidth: self.edgeLineWidth)
                        } else {
                            Diamond()
                                .fill(self.cardColor)
                                .opacity(self.card.shading == .solid ? 1 : self.stripedOpacity)
                        }
                    } else if self.card.shape == .oval {
                        if self.card.shading == .open {
                            Capsule()
                                .stroke(self.cardColor, lineWidth: self.edgeLineWidth)
                        } else {
                            Capsule()
                                .fill(self.cardColor)
                                .opacity(self.card.shading == .solid ? 1 : self.stripedOpacity)
                        }
                    } else {
                        if self.card.shading == .open {
                            Rectangle()
                                .stroke(self.cardColor, lineWidth: self.edgeLineWidth)
                        } else {
                            Rectangle()
                                .fill(self.cardColor)
                                .opacity(self.card.shading == .solid ? 1 : self.stripedOpacity)
                        }
                    }
                }
                .frame(
                    width: size.height / self.cardToCardContentRatio,
                    height: size.width / self.cardToCardContentRatio
                )
            }
        }
    }
    
    // MARK: - Drawing constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let stripedOpacity = 0.4
    private let cardToCardContentRatio: CGFloat = 5
    private let animationDuration = 0.75

}

// MARK: - Previews

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetGameModel.Card(id: 1, number: .three, shape: .oval, shading: .open, color: .red)
        return CardView(card: card)
    }
}
