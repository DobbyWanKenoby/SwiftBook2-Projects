//
//  Game.swift
//  Right on target
//
//  Created by USOV Vasily
//

struct Game {
    // Количество заработанных очков
    var score = 0
    // Загаданное значение
    var secretValue = 0
    // Закончена ли игра
    var isGameEnded: Bool {
        currentRound >= roundsCount
    }
    
    // Диапазон для выбора случайного значения
    private let secretValueRange: ClosedRange<Int>
    // Максимальное загаданное значение
    private var maxSecretValue: Int {
        secretValueRange.upperBound
    }
    // Количество раундов
    private var roundsCount: Int
    // Текущий раунд
    private var currentRound = 1
    
    init(secretValueRange: ClosedRange<Int>, rounds: Int) {
        self.secretValueRange = secretValueRange
        roundsCount = rounds
        generateNewSecretValue()
    }
    
    // Начать новую игру
    mutating func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    // Начать новый раунд
    mutating func startNewRound() {
        generateNewSecretValue()
        currentRound += 1
    }
    
    // Подсчитывает количество очков
    mutating func calculateScore(withRoundScore value: Int) {
        let roundResult = if value > secretValue {
            50 - value + secretValue
        } else if value < secretValue {
            50 - secretValue + value
        } else {
            50
        }
        score += roundResult
    }
    
    // Сгенерировать новое секретное значение
    private mutating func generateNewSecretValue() {
        var newSecretValue: Int
        repeat {
            newSecretValue = Int.random(in: secretValueRange)
        } while newSecretValue == secretValue
        secretValue = newSecretValue
    }
}
