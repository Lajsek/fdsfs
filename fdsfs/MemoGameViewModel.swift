
import SwiftUI

class MemoGameViewModel: ObservableObject {
    private static let animals = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻"]
    private static let vehicles = ["🚓","🚌","🚜","🚗","🚲","🚞","🛺"]
    private static let flags = ["🇩🇿","🇦🇩","🇧🇬","🇾🇪","🇻🇳","🇮🇹","🇫🇴"]
    
    public static var theme: Int = 1
    static var color: Color  = Color.red
    
    @Published private var  model = MemoGameViewModel.create(theme: MemoGameViewModel.theme)
    
    
    static func create(theme: Int) -> MemoGameModel<String> {
        
        var emojisArray: [String]
        var pairsNumber: Int
        
        switch theme {
        case 2:
            emojisArray = animals
            pairsNumber = 8
            color = .orange
            
        case 3:
            emojisArray = flags
            pairsNumber = 6
            color = .green
            
        default:
            emojisArray = vehicles
            pairsNumber = 7
            color = .red
        }
        
        return MemoGameModel<String>(
            
            numberPairsOfCard: pairsNumber) { i in
                
                    if emojisArray.indices.contains(i){
                        return emojisArray[i]
                    } else {
                        return "❓"
                    }
                
            }
    }
    
    
    
    var cards: Array<MemoGameModel<String>.Card>{
        return model.cards
    }
    

    func shuffle() {
        withAnimation {
            model.shuffle()
        }
    }
    
    func choose(card: MemoGameModel<String>.Card){
        withAnimation {
            model.choose(card)
        }
    }
    
    func changeTheme(to theme: Int) {
        MemoGameViewModel.theme = theme
        model = MemoGameViewModel.create(theme: theme)
        shuffle()
        
    }

}
