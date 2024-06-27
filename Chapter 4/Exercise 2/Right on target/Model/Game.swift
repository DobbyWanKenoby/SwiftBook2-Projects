//
//  Game.swift
//  Right on target
//
//  Created by USOV Vasily
//

// MARK: - Round

struct Round<G: IGenerator> {
    // Количество очков
    var score: Int = 0
    // Текущее секртное число
    private var secretValue: Int = 0
    private let generator: G
    
    init(generator: G) {
        self.generator = generator
    }
    
    // Попытка отгадывания числа
    // Возвращает текущее количество очков
    mutating func tryGuess(witValue value: Int) -> Int {
        calculateScore(withValue: value)
        return score
    }
    
    // Регенерация загаданного значения
    mutating func regenerateSecretValue() -> Int {
        secretValue = generator.generateSecretValue()
        return secretValue
    }
    
    private mutating func calculateScore(withValue value: Int) {
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

struct Game {
    private var round: Round<Generator>
    // Количество попыток, которое осталось
    private var tryGuessCountLeft: Int
    private let generator = Generator(range: 1...50)
    
    init(firstRoundTryGuessCounts: Int) {
        round = Round(generator: generator)
        tryGuessCountLeft = firstRoundTryGuessCounts
    }
    
    // Попытка отгадывания
    mutating func tryGuess(witValue value: Int) -> (score: Int, isGameEnded: Bool) {
        let score = round.tryGuess(witValue: value)
        tryGuessCountLeft -= 1
        return (score: score, isGameEnded: tryGuessCountLeft <= 0)
    }
    
    mutating func startNewRound(withTryCounts: Int) -> Int {
        round = Round(generator: generator)
        tryGuessCountLeft = withTryCounts
        return round.regenerateSecretValue()
    }
    
    mutating func regenerateSecretValue() -> Int {
        round.regenerateSecretValue()
    }
}
