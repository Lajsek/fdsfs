//
//  ButtonView.swift
//  fdsfs
//
//  Created by student on 14/11/2023.
//

import SwiftUI

struct ButtonView : View {
    var action: () -> Void
    var emoji: String = ""
    var text: String = ""
    
    var body: some View {
        VStack{
            
            Text(emoji)
            Text(text)
            
        }.onTapGesture {
            action()
        }
    }
}

#Preview {
    ButtonView(action: {})
}
