//
//  Game.swift
//  Right on target
//
//  Created by USOV Vasily
//

// MARK: - Generator

protocol IGenerator {
    var maxSecretValue: Int { get }
    func generateSecretValue() -> Int
}

struct Generator: IGenerator {
    var maxSecretValue: Int {
        range.upperBound
    }
    private let range: ClosedRange<Int>
    init(range: ClosedRange<Int>) {
        self.range = range
    }
    func generateSecretValue() -> Int {
        Int.random(in: range)
    }
}

// MARK: - Game

// Дженерик позволит перенести вычисление итогового типа в compile time
// и избежать использования экзистенциального контейнера из-за протокола IGenerator
struct Game<G: IGenerator> {
    // Количество заработанных очков
    var score = 0
    // Загаданное значение
    var secretValue = 0
    // Закончена ли игра
    var isGameEnded: Bool {
        currentRound >= roundsCount
    }
    
    // Количество раундов
    private var roundsCount: Int
    // Текущий раунд
    private var currentRound = 0
    // Генератор случайного значения
    private let generator: G
    
    init(generator: G, rounds: Int) {
        self.generator = generator
        roundsCount = rounds
        startNewRound()
    }
    
    // Начать новую игру
    mutating func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    // Начать новый раунд
    mutating func startNewRound() {
        secretValue = generator.generateSecretValue()
        currentRound += 1
    }
    
    // Подсчитывает количество очков
    mutating func calculateScore(withRoundScore value: Int) {
        let roundResult = if value > secretValue {
            generator.maxSecretValue - value + secretValue
        } else if value < secretValue {
            generator.maxSecretValue - secretValue + value
        } else {
            generator.maxSecretValue
        }
        score += roundResult
    }
}
