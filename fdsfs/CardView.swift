//
//  CardView.swift
//  fdsfs
//
//  Created by student on 14/11/2023.
//

import SwiftUI

struct CardView : View {
    
    var card: MemoGameModel<String>.Card
    var viewModel: MemoGameViewModel
       
       init(card: MemoGameModel<String>.Card, viewModel: MemoGameViewModel) {
           self.card  = card
           self.viewModel = viewModel
       }
       
      
       var body: some View {
           
               ZStack {
                   RoundedRectangle(cornerRadius: 12)
                       .fill(card.isFaceUp ? Color.white : Color(MemoGameViewModel.color))
                           .overlay(
                               RoundedRectangle(cornerRadius: 12)
                                   .strokeBorder(lineWidth: 3)
                                   .opacity(card.isFaceUp ? 1 : 0)
                           )
                           .overlay(
                               Text(card.content)
                                   .font(.system(size: 200))
                                   .minimumScaleFactor(0.01)
                                   .aspectRatio(1, contentMode: .fit)
                                   .opacity(card.isFaceUp ? 1 : 0)
                           )
               }
               .onTapGesture {
                   viewModel.choose(card: card)
               }

       }
   }
