//
//  ViewModel.swift
//  Lion Match
//
//  Created by Tyler Hillsman on 4/23/24.
//

import Foundation
import SwiftUI
import Observation

@Observable class ViewModel {
    
    let emoji: [String] = []
    let colors: [Color] = []

    var message = ""
    var score = 0 {
        didSet {
            showConfettiIfWon()
        }
    }
    
    var cards: [Card] = [] {
        didSet {
            checkStatus()
        }
    }
        
    func startNewGame() {
        score = 0
        let allEmoji = (emoji + emoji).shuffled()
        cards = buildCards(allEmoji)
    }
    
    func checkStatus() {
        let faceUpCards = findFaceUpCards(cards)
        if faceUpCards.count == 2 {
            if doFaceUpCardsMatch(faceUpCards) {
//                message = "It's a match!"
//                score += 1
//                let newCards = changeFaceUpCards(cards, to: .matched)
//                updateCards(to: newCards, inSeconds: 2)
            } else {
//                message = "Try again"
//                let newCards = changeFaceUpCards(cards, to: .faceDown)
//                updateCards(to: newCards, inSeconds: 2)
            }
        }
    }
    
    // Helper methods
    
    func doFaceUpCardsMatch(_ faceUpCards: [Card]) -> Bool {
        faceUpCards.allSatisfy({ $0.emoji == faceUpCards.first?.emoji })
    }
    
    func findFaceUpCards(_ cards: [Card]) -> [Card] {
        cards.filter { $0.state == .faceUp }
    }
    
    func changeFaceUpCards(_ cards: [Card], to state: Card.State) -> [Card] {
        cards.reduce([], { partialResult, card in
            var newCopy = card
            if newCopy.state == .faceUp {
                newCopy.state = state
            }
            return partialResult + [newCopy]
        })
    }
    
    func updateCards(to newCards: [Card], inSeconds seconds: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.message = ""
            self.cards = newCards
        }
    }
    
    func showConfettiIfWon() {
        if score == emoji.count {
            confetti += 1
        }
    }
    
    var confetti = 0
    
    func buildCards(_ emoji: [String]) -> [Card] {
        var counter = -1
        return emoji.map { emoji in
            counter += 1
            return Card(color: colors[counter % colors.count], emoji: emoji, state: .faceDown)
        }
    }
    
    var didWin: Bool {
        score == emoji.count
    }
    
    var scoreLabel: String {
        String(score) + "/" + String(emoji.count)
    }
}

struct Card: Identifiable, Equatable {
    
    let id = UUID()
    
    let color: Color
    let emoji: String
    var state: State
    
    enum State {
        case faceDown
        case faceUp
        case matched
    }
}
