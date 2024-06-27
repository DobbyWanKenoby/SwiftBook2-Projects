//
// Класс GameFactory создан в соответствии с паттерном "Абстрактная фабрика"
// Используется в качестве единой точки создания экземпляров класса Game для использования в программе
//

import Foundation

final class GameFactory {
    
    static func getNumericGame(withRounds rounds: Int) -> Game<SecretNumericValue> {
        let range = 1...50
        let secretValue = SecretNumericValue(initialValue: 0) { _ in
            return Int.random(in: range)
        }
        return Game<SecretNumericValue>(secretValue: secretValue, rounds: rounds) { secretValue, userValue in
            let compareResult = if secretValue.value == userValue.value {
                range.upperBound
            } else if secretValue.value > userValue.value {
                range.upperBound - (secretValue.value - userValue.value)
            } else {
                range.upperBound - (userValue.value - secretValue.value)
            }
            return compareResult
        }
    }
    
    static func getColorGame(withRounds rounds: Int) -> Game<SecretColorValue> {
        let initialSecretColor = Color()
        let secretValue = SecretColorValue(initialValue: initialSecretColor) { color in
            var updatedColor = color
            updatedColor.red = Array(0...255).randomElement()!
            updatedColor.green = Array(0...255).randomElement()!
            updatedColor.blue = Array(0...255).randomElement()!
            return updatedColor
        }
        return Game<SecretColorValue>(secretValue: secretValue, rounds: rounds) { secretValue, userValue in
            if secretValue.value == userValue.value {
                return 1
            } else {
                return 0
            }
        }
    }
    
}
