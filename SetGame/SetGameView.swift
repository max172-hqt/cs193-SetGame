//
//  ContentView.swift
//  SetGame
//
//  Created by Huy Tran on 9/14/20.
//  Copyright © 2020 Huy Tran. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        VStack {
            
            Text("Deck: \(self.viewModel.numberOfRemainingCards) cards")
                .frame(maxWidth: .infinity)
                .padding()
            
            Grid(self.viewModel.currentCards) { card in
                CardView(card: card)
                    .padding()
                    .aspectRatio(0.75, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: self.animationDuration)) {
                            self.viewModel.chooseCard(card: card)
                        }
                }
                .transition(.offset(size))
            }
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    self.viewModel.initCards()
                }
            }
            
            
            HStack {
                Button("+3") {
                    withAnimation(.easeInOut(duration: self.animationDuration)) {
                        self.viewModel.addThreeCards()
                    }
                }
                .disabled(self.viewModel.numberOfRemainingCards == 0)
                .frame(maxWidth: .infinity)
                
                Button("New Game") {
                    withAnimation(.easeInOut(duration: self.animationDuration)) {
                        self.viewModel.resetGame()
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .font(.body)
        }
    }
    
    private let animationDuration = 0.75
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
