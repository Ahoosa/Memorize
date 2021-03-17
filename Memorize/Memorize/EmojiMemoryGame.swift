//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-04.
//  Copyright © 2021 Ahoo. All rights reserved.
//
//this is the ViewModel: doorway to get to the model
import SwiftUI


//advantage of class: easy to share since it lives in the heap and we have pointers to it
class EmojiMemoryGame: ObservableObject {
    //saying its private it can only be modified by EmojiMemoryGame
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.CreateMemoryGame() //published changes model when it changes like flips card and etc
   
    private enum emojiThemes: CaseIterable{
        case faces
        case halloween
        case hearts
        case flags
        case animals
        case food
    }
     private static var colorCard: UIColor = UIColor.orange
     private static var name: String = "emoji"
     private static var emojis = [String]()
     
    
    private static func getCards()->Array<String>{
        let randomEmoji = emojiThemes.allCases.randomElement()
        
        switch randomEmoji {
            case .faces: emojis = ["😀", "😜", "🥰", "🤠", "🥶", "🤩", "😱"]
            colorCard = UIColor.yellow
            name = "Faces"
            case .halloween: emojis = ["👻", "🎃", "🕷", "🧟‍♀️", "🧞‍♂️", "🧝🏼‍♀️", "🍬", "🧠", "🧙🏻‍♀️"]
            colorCard = UIColor.orange
            name = "Halloween"
            case .hearts: emojis = ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎"]
            colorCard = UIColor.systemPink
            name = "Hearts"
            case .flags: emojis = ["🇨🇦","🇩🇪","🇬🇷","🇰🇷","🇬🇧","🇺🇸","🇮🇹","🇪🇸"]
            colorCard = UIColor.green
            name = "Flags"
            case .animals: emojis = ["🐶","🐷","🐒","🦋","🐴","🐬","🐻","🦩","🦀","🐧"]
            colorCard = UIColor.brown
            name = "Animals"
            case .food: emojis = ["🍎","🍑", "🍉","🍇","🥑","🌮","🍦","🍫","🍪","🍕","🍔","🍱"]
            colorCard = UIColor.red
            name = "Food"
        default: emojis = []
        }
        
        emojis.shuffle()
        return emojis
    }
    
    private static func CreateMemoryGame() -> MemoryGame<String> {
        emojis = getCards()
        return MemoryGame<String>(numberOfPairsOfCards: [2,3,4,5].randomElement()!, cardContentFactory: { pairIndex  in
            return emojis[pairIndex] }, color: colorCard, theme: name)
    }
  
    
    //MARK: - Access to the Model
    
   
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    var colorOfCard: UIColor{
        return model.colorOfCard
    }

    var nameOfTheme: String{
        return model.nameTheme
    }
    
    var points: Int{
        return model.points
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func reset(){
        model = EmojiMemoryGame.CreateMemoryGame()
    }
    
}
