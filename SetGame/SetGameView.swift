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
        VStack {
            Grid(self.viewModel.currentCards) { card in
                CardView(card: card)
                    .padding()
                    .aspectRatio(0.75, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.75)) {
                            self.viewModel.chooseCard(card: card)
                        }
                }
                .transition(.scale)
            }
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    self.viewModel.initCards()
                }
            }
            
            
            HStack {
                Button("+3") {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        self.viewModel.addThreeCards()
                    }
                }
                    .disabled(viewModel.numberOfRemainingCards == 0)
                Spacer()
                Button("New Game") {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        self.viewModel.resetGame()
                    }
                }
            }
                .padding()
                .font(.title)
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
