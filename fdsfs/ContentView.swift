
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : MemoGameViewModel
    @State var offsetY : CGFloat = 0
    @State var offSetX : CGFloat = -100
    @State var colorText : Color =  Color.black
        var body: some View {
            VStack {
                Text("MemoGame").font(.largeTitle).padding().offset(x: offSetX)
                    .shadow(color: colorText, radius: 2, x: 2, y: 2).onTapGesture {
                        withAnimation(.linear(duration: 2).repeatForever()){
                            offSetX = 100
                            colorText = .red
                        }
                    }
                Spacer()
                ScrollView{
                    generateCards
                }
                selectTheme
                Spacer()
            }
            .padding()
        }
        
    
        var generateCards : some View {
    
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],spacing:0)
            {
                ForEach(viewModel.cards){card in
                    
                    CardView(card: card, viewModel: viewModel)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(3)
                        .onTapGesture {
                            viewModel.choose(card: card)
                        }
                }
            }.foregroundColor(MemoGameViewModel.color)
        }
    
        var selectTheme: some View {
            HStack{
                ButtonView(action: {
                    viewModel.changeTheme(to: 1)}, emoji: "🛵" , text: "Pojazdy").foregroundStyle(.red)
                Spacer()
                ButtonView(action: {
            viewModel.changeTheme(to: 2)}, emoji: "🦉", text: "Zwierzeta").foregroundStyle(.orange)
                Spacer()
                ButtonView(action: {
                    viewModel.changeTheme(to: 3)}, emoji: "🇵🇱", text: "Flagi").foregroundStyle(.green)
            }.padding(20)
        }

}

#Preview {
    ContentView(viewModel: MemoGameViewModel())
}
