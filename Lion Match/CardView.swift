//
//  CardView.swift
//  Lion Match
//
//  Created by Tyler Hillsman on 4/23/24.
//

import SwiftUI

struct CardView: View {
    
    @Binding var card: Card
    
    var body: some View {
        Rectangle()
            .overlay {
                Text(card.emoji)
                    .font(.largeTitle)
                    .scaleEffect(2.5)
                    .opacity(card.state == .faceUp ? 1 : 0)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
            .foregroundColor(card.state == .faceUp ? .white : card.color)
            .opacity(card.state == .matched ? 0.2 : 1.0)
            .cornerRadius(10)
            .frame(width: 140, height: 200)
            .shadow(color: .gray, radius: 10)
            .onTapGesture {
                if card.state == .faceDown {
                    card.state = .faceUp
                } else if card.state == .faceUp {
                    card.state = .faceDown
                }
            }
            .rotation3DEffect(.degrees(card.state == .faceDown ? 0 : 180), axis: (x: 0, y: 1, z: 0))
            .animation(.default, value: card.state)
    }
}

#Preview {
    @State var card = Card(color: .red, emoji: "🍕", state: .matched)
    return CardView(card: $card)
}
