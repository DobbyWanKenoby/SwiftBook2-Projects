//
//  Right_on_target_SwiftTesting.swift
//  Right on target SwiftTesting
//
//  Created by USOV Vasily on 16.08.2024.
//

import Testing
@testable import Right_on_target

struct Right_on_target_SwiftTesting {
    
    let randomValueRange: ClosedRange<Int>
    var game: Game
    
    init() {
        // Диапазон для выбора случайного числа
        randomValueRange = 1...100
        // Количество раундов до конца игры
        let rounds = 3
        // Создание игры
        game = Game(secretValueRange: randomValueRange, rounds: rounds)
    }
    
    @Test func gameCreation() {
    
        // Проверим, что игра не завершена сразу после ее начала
        #expect(game.isGameEnded == false,
                "Игра не должна быть завершена сразу после ее начала")
        
        // Проверим, что случайное число входит в указанный интервал случайных чисел
        #expect(randomValueRange.contains(game.secretValue),
                  "Случайное число должно входить в определенны при создании игры даиапазон")
        
        #expect(game.score == 0,
                  "Количество очков до отгадывания первого числа должно быть равно нулю")
    }

@Test mutating func gameRound() {
    // запоминаем секретное число
    let secretValue = game.secretValue
    
    // подсчитываем очки за раунд
    game.calculateScore(withRoundScore: secretValue)
    
    #expect(game.score != 0, "Количество очков за раунд после успешного отгадывания не должно быть равно 0")
    
    // Стартуем новый раунд
    game.startNewRound()
    
    // Проверяем новое загаданное число
    // Оно должно быть не равно предыдущему
    #expect(secretValue != game.secretValue, "Новое загаданное число должно быть не равно предыдущему")
    
    // Игра не должна быть завершена, так как в ней 3 равнда
    #expect(game.isGameEnded == false, "Игра не должна быть завершена до конца третьего раунда")
}

@Test mutating func gameEnd() {
    
    // Трижды стартуем новый раунд
    for _ in 1...3 {
        game.startNewRound()
    }
    
    // Игра не должна быть завершена, так как в ней 3 равнда
    #expect(game.isGameEnded, "Игра  должна быть завершена по окончанию последнего раунда")
    
    // Сохраняем последнее загаданное число
    let oldSecretValue = game.secretValue
    
    // Перезапускаем игру
    game.restartGame()
    
    // Проверим, что игра не завершена сразу после ее начала
    #expect(game.isGameEnded == false,
              "Игра не должна быть завершена сразу после ее начала")
    
    // Проверим, что загаданное число было перегенерировано
    #expect(game.secretValue != oldSecretValue,
              "Случайное число должно быть перегенерировано после запуска новой игры")
    
    #expect(game.score == 0,
              "Количество очков до отгадывания первого числа должно быть равно нулю")
}
    
}
