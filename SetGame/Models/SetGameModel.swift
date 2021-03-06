//
//  SetGame.swift
//  SetGame
//
//  Created by Huy Tran on 9/14/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI


struct SetGameModel {
    var deck: Array<Card>
    var currentCards: Array<Card>
    
    // MARK: - Model initializer
    init() {
        deck = Array<Card>()
        currentCards = Array<Card>()
        
        var index = 0
        
        // initilize cards
        for number in Card.Feature.allCases {
            for shape in Card.Feature.allCases {
                for shading in Card.Feature.allCases {
                    for color in Card.Feature.allCases {
                        let card = Card(id: index, number: number, shape: shape, shading: shading, color: color)
                        deck.append(card)
                        index += 1
                    }
                }
            }
        }
        
//        deck = Array(deck[0...deck.index(0, offsetBy: 11)])
        deck.shuffle()
    }
    
    // MARK: - Game Design
    mutating func deal(numberOfCards: Int) -> Void {
        if indexOfSelectedCards.count == 3 && isASet(ids: indexOfSelectedCards) {
            indexOfSelectedCards = []
        } else if deck.count >= numberOfCards {
            for _ in 0..<numberOfCards {
                var card = deck.remove(at: 0)
                card.inGame = true
                currentCards.append(card)
            }
        }
    }
    
    mutating func chooseCard(card: Card) -> Void {
        if let chosenIndex = currentCards.firstIndex(matching: card) {
            if indexOfSelectedCards.count != 3 || !currentCards[chosenIndex].isSelected {
                currentCards[chosenIndex].isSelected.toggle()
            }
            let numberOfSelectedCards = indexOfSelectedCards.count
            
            if numberOfSelectedCards == 3 {
                let cardsFormedASet = isASet(ids: indexOfSelectedCards)
                
                for index in indexOfSelectedCards {
                    currentCards[index].isMatched = cardsFormedASet
                }
            } else if numberOfSelectedCards == 4 {
                indexOfSelectedCards = [chosenIndex]
            } else {
                for index in currentCards.indices {
                    currentCards[index].isMatched = nil
                }
            }
        }
    }
    
    var indexOfSelectedCards: [Int] {
        get {
            currentCards.indices.filter { currentCards[$0].isSelected }
        }
        set {
            // If 3 cards are already selected, select another one
            // will deselect / remove the 3 cards if mismatched / matched
            for index in currentCards.indices {
                currentCards[index].isSelected = index == newValue.first
                if let isMatched = currentCards[index].isMatched {
                    if isMatched {
                        currentCards[index].inGame = false
                        

                        if deck.count > 0 {
                            
                            currentCards[index] = deck.remove(at: 0)
                            currentCards[index].inGame = true
                        }
                    } else {
                        currentCards[index].isMatched = nil
                    }
                }
            }
            
            // End game
            // When deck is empty, vacated slots (cards with !inGame are not removed)
            // should be made available for remaining cards
            // -> remove cards with !inGame
            currentCards.removeAll { !$0.inGame }
            print(currentCards)
            print(currentCards.filter {$0.isMatched != nil&&$0.isMatched!})
        }
    }
    
    private func isASet(ids: [Int]) -> Bool {
        let cards = ids.map { id in currentCards[id] }
        return cards.map({ card in card.color }).formedASet &&
            cards.map({ card in card.shape }).formedASet &&
            cards.map({ card in card.shading }).formedASet &&
            cards.map({ card in card.number }).formedASet
//        return true
    }
    
    // MARK: - Struct Card
    struct Card: Identifiable {
        var id: Int
        var number: Feature
        var shape: Feature
        var shading: Feature
        var color: Feature
        var isSelected: Bool = false
        var isMatched: Bool?
        var inGame: Bool = false
        
        enum Feature: Int, CaseIterable {
            case one = 1, two, three
        }
    }
}


