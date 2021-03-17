//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-04.
//  Copyright © 2021 Ahoo. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable{ //need to tell me what cardcontent is since it is a dont care
    private(set) var cards: Array<Card> //read only
    private(set) var colorOfCard: UIColor
    private(set) var nameTheme: String
    private var seenSoFar: Array<Int>
    private(set) var points: Int
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            cards.indices.filter { index in return cards[index].isFaceUp }.only //instead of index can have $0 ie cards[$0]     
        }
        set{
            for index in cards.indices{
                    cards[index].isFaceUp = index == newValue
                
            }
        }
    }
    private mutating func removeMatched(id1: Int,id2: Int) {
        if let seen1 = seenSoFar.firstIndex(of: id1){ seenSoFar.remove(at: seen1) }
        if let seen2 = seenSoFar.firstIndex(of: id2){ seenSoFar.remove(at: seen2) }
    }
    
    private mutating func calculatePoints(id1: Int,id2: Int){
         if seenSoFar.contains(id1) && seenSoFar.contains(id2){
            points -= 2
         }else if seenSoFar.contains(id1) || seenSoFar.contains(id2){
            points -= 1
        }
        if !seenSoFar.contains(id1) { seenSoFar.append(id1) }
        if !seenSoFar.contains(id2) { seenSoFar.append(id2) }
       
    }
    
    mutating func choose(card: Card){ //mutating since its changing itself
        print("card chosen: \(card)") //can print things this way
      
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            //we use if let so that choose works only if we find the index also note that comma here is a sequential and
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    removeMatched(id1: card.id , id2: cards[potentialMatchIndex].id)
                    points += 2
                }else{ calculatePoints(id1: card.id , id2: cards[potentialMatchIndex].id) }
                
                 self.cards[chosenIndex].isFaceUp = true
            }
            else{
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
            
        }
    
       
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent, color: UIColor, theme: String){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card( content: content,id: pairIndex*2+1))
        }
        cards.shuffle()
        colorOfCard = color
        nameTheme = theme
        seenSoFar = Array<Int>()
        points = 0
    }
    

    struct Card: Identifiable { //dont need to private(set) this since cards is private(set) already
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
