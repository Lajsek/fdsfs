//
//  MemoGameModel.swift
//  fdsfs
//
//

import Foundation


struct MemoGameModel<CardContent: Equatable> {
    private (set) var cards : Array<Card>
    
    init(numberPairsOfCard: Int, cardContentFactory: (Int)->CardContent){
        cards =  []
        
        for pairIndex in 0..<max(2,numberPairsOfCard) {
        
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    mutating func choose(_ card: Card){
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        return cards.firstIndex(where: {$0.id == card.id})!
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable{
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: String
    }
}
