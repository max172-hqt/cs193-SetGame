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
    
//    var numberOfSelectedCards: Int {
//        model.indexOfSelectedCards.count
//    }
    
    // MARK: - Intents
    var currentCards: Array<SetGameModel.Card> {
        return model.currentCards
    }
    
    func addThreeCards() -> Void {
        model.addThreeCards()
    }
    
    func chooseCard(card: SetGameModel.Card) -> Void {
        model.chooseCard(card: card)
    }
    
    func resetGame() -> Void {
        model = SetGameModel()
    }
}
