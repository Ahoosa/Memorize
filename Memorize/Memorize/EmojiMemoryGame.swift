//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-04.
//  Copyright ยฉ 2021 Ahoo. All rights reserved.
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
            case .faces: emojis = ["๐", "๐", "๐ฅฐ", "๐ค ", "๐ฅถ", "๐คฉ", "๐ฑ"]
            colorCard = UIColor.yellow
            name = "Faces"
            case .halloween: emojis = ["๐ป", "๐", "๐ท", "๐งโโ๏ธ", "๐งโโ๏ธ", "๐ง๐ผโโ๏ธ", "๐ฌ", "๐ง ", "๐ง๐ปโโ๏ธ"]
            colorCard = UIColor.orange
            name = "Halloween"
            case .hearts: emojis = ["โค๏ธ","๐งก","๐","๐","๐","๐","๐ค","๐ค","๐ค"]
            colorCard = UIColor.systemPink
            name = "Hearts"
            case .flags: emojis = ["๐จ๐ฆ","๐ฉ๐ช","๐ฌ๐ท","๐ฐ๐ท","๐ฌ๐ง","๐บ๐ธ","๐ฎ๐น","๐ช๐ธ"]
            colorCard = UIColor.green
            name = "Flags"
            case .animals: emojis = ["๐ถ","๐ท","๐","๐ฆ","๐ด","๐ฌ","๐ป","๐ฆฉ","๐ฆ","๐ง"]
            colorCard = UIColor.brown
            name = "Animals"
            case .food: emojis = ["๐","๐", "๐","๐","๐ฅ","๐ฎ","๐ฆ","๐ซ","๐ช","๐","๐","๐ฑ"]
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
