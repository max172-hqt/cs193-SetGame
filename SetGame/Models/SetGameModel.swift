//
//  SetGame.swift
//  SetGame
//
//  Created by Huy Tran on 9/14/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI


struct SetGameModel {
    private var deck: [Card]
    var currentCards: [Card]
    
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
            currentCards.append(deck.remove(at: 0))
        }
    }
    
    // MARK: - Game Design
    mutating func addThreeCards() -> Void {
        // TODO: Check if deck has remaining cards
        for _ in 0..<3 {
            currentCards.append(deck.remove(at: 0))
        }
    }
    
    mutating func chooseCard(card: Card) -> Void {
        if let chosenIndex = currentCards.firstIndex(matching: card) {
            currentCards[chosenIndex].isSelected = true
        }
    }
    
    // MARK: - Struct Card
    struct Card: Identifiable {
        var id: Int
        var number: Number
        var shape: Shape
        var shading: Shading
        var color: ShapeColor
        var isSelected: Bool = false
        var isMatched: Bool = false
        
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


