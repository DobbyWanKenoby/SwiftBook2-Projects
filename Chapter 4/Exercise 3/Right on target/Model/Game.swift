//
// Сущность "Игра"
//

struct Game<T: ISecretValue> {
    typealias SecretType = T
    var score: Int = 0
    // секретное значение
    var secretValue: T
    // замыкание производит сравнение значений и возвращает заработанные очки
    private var compareClosure: (T, T) -> Int
    private var roundsLeft: Int = 0
    var isGameEnded: Bool {
        roundsLeft <= 0
    }

    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsLeft = rounds
        self.compareClosure = compareClosure
        startNewRound()
    }
    
    mutating func restartGame(withRounds rounds: Int) {
        score = 0
        roundsLeft = rounds
        startNewRound()
    }

    mutating func startNewRound() {
        roundsLeft -= 1
        self.secretValue.setRandomValue()
    }
    
    mutating func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure(secretValue, userValue)
    }
    
}
