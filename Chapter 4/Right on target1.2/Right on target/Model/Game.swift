//
//  Game.swift
//  Right on target
//
//  Created by USOV Vasily
//

protocol GameProtocol {
    // Количество заработанных очков
    var score: Int { get }
    // Загаданное значение
    var secretValue: Int { get }
    // Проверяет, закончена ли игра
    var isGameEnded: Bool { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд (обновляет загаданное число)
    func startNewRound()
    // Сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(withRoundScore value: Int)
}

final class Game: GameProtocol {
    var score = 0
    var secretValue = 0
    var isGameEnded: Bool {
        currentRound >= roundsCount
    }
    
    // Минимальное загаданное значение
    private var minSecretValue: Int
    // Максимальное загаданное значение
    private var maxSecretValue: Int
    // Количество раундов
    private var roundsCount: Int
    // Текущий раунд
    private var currentRound = 1
    
    init?(startValue: Int, endValue: Int, rounds: Int) {
        // Стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        minSecretValue = startValue
        maxSecretValue = endValue
        roundsCount = rounds
        generateNewSecretValue()
    }
    
    func restartGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        generateNewSecretValue()
        currentRound += 1
    }
    
    // Сгенерировать новое секретное значение
    private func generateNewSecretValue() {
        secretValue = (minSecretValue...maxSecretValue).randomElement()!
    }
    
    // Подсчитывает количество очков
    func calculateScore(withRoundScore value: Int) {
        let roundResult = if value > secretValue {
            50 - value + secretValue
        } else if value < secretValue {
            50 - secretValue + value
        } else {
            50
        }
        score += roundResult
    }
}
