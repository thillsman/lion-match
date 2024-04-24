//
//  ContentView.swift
//  Lion Match
//
//  Created by Tyler Hillsman on 4/23/24.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    
    @State var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.scoreLabel)
                
                Spacer()
                
                Button {
                    viewModel.startNewGame()
                } label: {
                    Text("New game")
                }
            }
            .overlay {
                Text(viewModel.message)
                    .font(.largeTitle)
                    .frame(height: 60)
            }
            .padding()
             
            
            if !viewModel.didWin {
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))]) {
                        ForEach($viewModel.cards) { card in
                            CardView(card: card)
                                .padding(16)
                        }
                    }
                    .padding()
                    .disabled(!viewModel.message.isEmpty)
                    .animation(.default, value: viewModel.cards)
                }
                
            } else {
                
                Spacer()
                Text("🎉 You won! 🎉")
                    .font(.largeTitle)
                Spacer()
                
            }
        }
        .confettiCannon(
            counter: $viewModel.confetti,
            num: 10,
            confettis: viewModel.emoji.map { .text($0) },
            confettiSize: 40,
            rainHeight: 1200,
            radius: 800,
            repetitions: 25,
            repetitionInterval: 0.2
        )
        .onAppear {
            viewModel.startNewGame()
        }
        .fontDesign(.rounded)
    }
}

#Preview {
    ContentView()
}
