//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ahoo Saeifar on 2021-01-03.
//  Copyright © 2021 Ahoo. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame //ObservedObject redraws changes
   
    
     var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Theme: "+self.viewModel.nameOfTheme).bold()
                        .offset(x: offsetTen)
                    Spacer()
                    Button(action: { self.viewModel.reset() }){
                        Text("New Game").bold()
                            .font(.system(size: buttonText))
                    }.offset(x:-offsetTen)
                }.foregroundColor(Color.blue)

                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                    }.padding(self.paddingCards)
                }
                .padding()
                .foregroundColor(Color.init(viewModel.colorOfCard))
                .layoutPriority(priorityCards)
                
                Text("Score: \(viewModel.points)").bold().font(.system(size: scoreTextSize))
                    .foregroundColor(Color.purple)
            }
            
        }
    }
     //MARK: drawing Constants
    
    private let buttonText: CGFloat = 20.0
    private let priority: Double = 5
    private let priorityCards: Double = 10
    private let paddingCards: CGFloat = 5
    private let scoreTextSize: CGFloat = 30
    private let offsetTen: CGFloat = 10
}

struct CardView: View{
    
    var card: MemoryGame<String>.Card
    
    var body:some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }


    private func body(for size: CGSize) -> some View {
             ZStack{
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .opacity(0.4)
                    .padding(5)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
             }.cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
        
    }

    //MARK: drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private func fontSize(for size: CGSize) ->CGFloat{
        min(size.width,size.height) * 0.70
    }
   
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
