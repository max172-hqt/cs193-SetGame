//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Huy Tran on 9/15/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var model: SetGameModel = SetGameModel()
    
    // MARK: - Intents
    var currentCards: Array<SetGameModel.Card> {
        return model.currentCards
    }
    
    var numberOfRemainingCards: Int {
        return model.deck.count
    }
    
    func initCards() -> Void {
        model.deal(numberOfCards: 12)
    }
    
    func addThreeCards() -> Void {
        model.deal(numberOfCards: 3)
    }
    
    func chooseCard(card: SetGameModel.Card) -> Void {
        model.chooseCard(card: card)
    }
    
    func resetGame() -> Void {
        model = SetGameModel()
        self.initCards()
    }
}

// MARK: - Display oriented extensions for Set Game View
extension SetGameModel.Card {
    var cardColor: Color {
        switch self.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    var cardShape: some Shape {
        switch self.shape {
        case .diamond:
            return AnyShape(Diamond())
        case .oval:
            return AnyShape(Capsule())
        case .squiggle:
            return AnyShape(Rectangle())
        }
    }
}

struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }

    private let _path: (CGRect) -> Path
}
