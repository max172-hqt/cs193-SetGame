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
//    var currentCards: Array<Card> {
//        return deck.filter { card in card.inGame }
//    }
    
    // MARK: - Model initializer
    init() {
        deck = Array<Card>()
        currentCards = Array<Card>()
        
        var index = 0
        
        // initilize cards
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for shading in Card.Shading.allCases {
                    for color in Card.ShapeColor.allCases {
                        let card = Card(id: index, number: number, shape: shape, shading: shading, color: color)
                        deck.append(card)
                        index += 1
                    }
                }
            }
        }
        
        deck.shuffle()
        
        // Deal cards. TODO: separate into deal method
        for _ in 0..<12 {
            var card = deck.remove(at: 0)
            card.inGame = true
            currentCards.append(card)
        }
    }
    
    // MARK: - Game Design
    mutating func addThreeCards() -> Void {
        if indexOfSelectedCards.count == 3 && isASet(ids: indexOfSelectedCards) {
            indexOfSelectedCards = []
        } else if deck.count > 0 {
            for _ in 0..<3 {
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
                        currentCards[index] = deck.remove(at: 0)
                        currentCards[index].inGame = true
                    } else {
                        currentCards[index].isMatched = nil
                    }
                }
            }
        }
    }
    
    private func isASet(ids: [Int]) -> Bool {
        let cards = ids.map { id in currentCards[id] }
        return cards.map({ card in card.color }).formedASet &&
            cards.map({ card in card.shape }).formedASet &&
            cards.map({ card in card.shading }).formedASet &&
            cards.map({ card in card.number }).formedASet
    }
    
    // MARK: - Struct Card
    struct Card: Identifiable {
        var id: Int
        var number: Number
        var shape: Shape
        var shading: Shading
        var color: ShapeColor
        var isSelected: Bool = false
        var isMatched: Bool?
        var inGame: Bool = false
        
        enum Number: Int, CaseIterable {
            case one = 1, two, three
        }
        
        enum Shape: String, CaseIterable {
            case diamond, squiggle, oval
        }
        
        enum Shading: String, CaseIterable {
            case solid, striped, open
        }
        
        enum ShapeColor: String, CaseIterable {
            case red, green, purple
        }
    }
}


