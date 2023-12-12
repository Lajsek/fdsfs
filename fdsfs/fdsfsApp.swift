import SwiftUI

struct Question {
    var text: String
    var options: [String]
    var correctAnswer: String
    var prize: Int
}

class GameModel: ObservableObject {
    @Published var playerName: String = ""
    @Published var currentQuestionIndex: Int = 0
    @Published var questions: [Question] = []
    let moneyPrizes: [Int] = [500, 1000, 2000, 5000, 10000, 20000, 40000, 75000, 125000, 250000, 500000, 1000000]
    @Published var currentPrize: Int = 0

    init() {
        questions = [
            Question(text: "Question 1", options: ["Option A", "Option B", "Option C", "Option D"], correctAnswer: "Option A", prize: 0),
            Question(text: "Question 2", options: ["Option A", "Option B", "Option C", "Option D"], correctAnswer: "Option B", prize: 0),
            Question(text: "Question 3", options: ["Option A", "Option B", "Option C", "Option D"], correctAnswer: "Option C", prize: 0),
            Question(text: "Question 4", options: ["Option A", "Option B", "Option C", "Option D"], correctAnswer: "Option D", prize: 0),
        ]
        assignMoneyPrizesAndSortQuestions()
    }

    func startGame() {
        currentQuestionIndex = 0
        currentPrize = moneyPrizes.first ?? 0
    }

    func submitAnswer(selectedAnswer: String) {
        let currentQuestion = questions[currentQuestionIndex]

        if selectedAnswer == currentQuestion.correctAnswer {
            currentPrize = moneyPrizes[currentQuestionIndex + 1]
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
            } else {
                print("Game Over - Show Summary")
            }
        } else {
            print("Game Over - Show Summary")
        }
    }

    func changeQuestion() {
        currentQuestionIndex += 1
    }

    private func assignMoneyPrizesAndSortQuestions() {
        for i in 0..<questions.count {
            questions[i].prize = moneyPrizes[i]
        }
        questions.sort { $0.prize < $1.prize }
    }
}

class GameViewModel: ObservableObject {
    @ObservedObject private var gameModel = GameModel()

    var playerName: String {
        gameModel.playerName
    }

    var currentQuestionIndex: Int {
        gameModel.currentQuestionIndex
    }

    var currentPrize: Int {
        gameModel.currentPrize
    }

    var questions: [Question] {
        gameModel.questions
    }

    func startGame() {
        withAnimation {
            gameModel.startGame()
        }
    }

    func submitAnswer(selectedAnswer: String) {
        withAnimation {
            gameModel.submitAnswer(selectedAnswer: selectedAnswer)
        }
    }

    func changeQuestion() {
        withAnimation {
            gameModel.changeQuestion()
        }
    }
}

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var selectedAnswer: String = ""

    var body: some View {
        VStack {
            Text("Player: \(viewModel.playerName)")
                .animation(.default)
            Text("Current Prize: \(viewModel.currentPrize) zł")
                .animation(.default)

            if viewModel.currentQuestionIndex < viewModel.questions.count {
                Text(viewModel.questions[viewModel.currentQuestionIndex].text)
                    .animation(.default)

                ForEach(viewModel.questions[viewModel.currentQuestionIndex].options.shuffled(), id: \.self) { option in
                    AnswerButton(option: option, selectedAnswer: $selectedAnswer)
                        .opacity(selectedAnswer.isEmpty ? 1.0 : 0.0)
                        .animation(.default)
                }
                .transition(.opacity)

                Button("Submit Answer") {
                    viewModel.submitAnswer(selectedAnswer: selectedAnswer)
                    selectedAnswer = ""
                }
                .disabled(selectedAnswer.isEmpty)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .animation(.default)
            } else {
                Text("Game Over - Show Summary")
                    .animation(.default)
                Text("Total Prize: \(viewModel.currentPrize) zł")
                    .animation(.default)
            }
        }
        .onAppear {
            viewModel.startGame()
        }
    }
}

struct AnswerButton: View {
    var option: String
    @Binding var selectedAnswer: String

    var body: some View {
        Button(action: {
            withAnimation {
                selectedAnswer = option
            }
        }) {
            Text(option)
                .padding()
                .foregroundColor(.white)
                .background(selectedAnswer == option ? Color.green : Color.gray)
                .cornerRadius(8)
                .animation(.default)
        }
        .disabled(!selectedAnswer.isEmpty)
    }
}

@main
struct MillionaireGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @ObservedObject private var gameViewModel = GameViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your name", text: $gameViewModel.playerName)
                    .padding()
                NavigationLink(destination: GameView(viewModel: gameViewModel)) {
                    Text("Start Game")
                }
            }
            .padding()
            .navigationTitle("Millionaire Game")
        }
    }
}

