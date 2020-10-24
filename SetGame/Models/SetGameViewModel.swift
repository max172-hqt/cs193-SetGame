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
