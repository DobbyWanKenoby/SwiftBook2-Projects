//
//  Right_on_target_XCTests.swift
//  Right on target XCTests
//
//  Created by USOV Vasily on 14.08.2024.
//

import XCTest
@testable import Right_on_target


final class Right_on_target_XCTests: XCTestCase {
    
    // Диапазон для выбора случайного числа
    let randomValueRange = 1...100
    // Количество раундов до конца игры
    let rounds = 3
    
    func testGameCreation() {
        // Создаем новый объект Игра
        let game = Game(secretValueRange: randomValueRange, rounds: rounds)
        
        // Проверим, что игра не завершена сразу после ее начала
        XCTAssert(game.isGameEnded == false,
                  "Игра не должна быть завершена сразу после ее начала")
        
        // Проверим, что случайное число входит в указанный интервал случайных чисел
        XCTAssert(randomValueRange.contains(game.secretValue),
                  "Случайное число должно входить в определенны при создании игры даиапазон")
        
        XCTAssert(game.score == 0,
                  "Количество очков до отгадывания первого числа должно быть равно нулю")
    }
    
    func testGameRound() {
        // Создаем новый объект Игра
        var game = Game(secretValueRange: randomValueRange, rounds: rounds)
        
        // запоминаем секретное число
        let secretValue = game.secretValue
        
        // подсчитываем очки за раунд
        game.calculateScore(withRoundScore: secretValue)
        
        XCTAssert(game.score != 0, "Количество очков за раунд после успешного отгадывания не должно быть равно 0")
        
        // Стартуем новый раунд
        game.startNewRound()
        
        // Проверяем новое загаданное число
        // Оно должно быть не равно предыдущему
        XCTAssert(secretValue != game.secretValue, "Новое загаданное число должно быть не равно предыдущему")
        
        // Игра не должна быть завершена, так как в ней 3 равнда
        XCTAssertFalse(game.isGameEnded, "Игра не должна быть завершена до конца третьего раунда")
    }
    
    func testGameEnd() {
        
        // Создаем новый объект Игра
        var game = Game(secretValueRange: randomValueRange, rounds: rounds)
        
        // Трижды стартуем новый раунд
        for _ in 1...3 {
            game.startNewRound()
        }
        
        // Игра не должна быть завершена, так как в ней 3 равнда
        XCTAssert(game.isGameEnded, "Игра  должна быть завершена по окончанию последнего раунда")
        
        // Сохраняем последнее загаданное число
        let oldSecretValue = game.secretValue
        
        // Перезапускаем игру
        game.restartGame()
        
        // Проверим, что игра не завершена сразу после ее начала
        XCTAssert(game.isGameEnded == false,
                  "Игра не должна быть завершена сразу после ее начала")
        
        // Проверим, что загаданное число было перегенерировано
        XCTAssert(game.secretValue != oldSecretValue,
                  "Случайное число должно быть перегенерировано после запуска новой игры")
        
        XCTAssert(game.score == 0,
                  "Количество очков до отгадывания первого числа должно быть равно нулю")
    }
}
