//
//  ViewController.swift
//  Right on target
//
//  Created by USOV Vasily
//

import UIKit

class ViewController: UIViewController {
    
    // Вспомогательный тип с конфигурационными данными
    enum Config {
        static let tryGuessCountsEachRound = 5
    }
    
    // Сущность "Игра"
    private var game = {
        return Game(firstRoundTryGuessCounts: Config.tryGuessCountsEachRound)
    }()
    
    // Элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // MARK: - Жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        let secretValue = game.regenerateSecretValue()
        updateLabelWithSecretNumber(newText: String(secretValue))
    }
    
    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        let resultRound = game.tryGuess(witValue: Int(slider.value))
        // Проверяем, окончена ли игра
        if resultRound.isGameEnded {
            showAlertWith(score: resultRound.score)
        } else {
            let secretValue = game.regenerateSecretValue()
            // Обновляем данные о текущем значении загаданного числа
            updateLabelWithSecretNumber(newText: String(secretValue))
        }
    }
    
    // MARK: - Обновление View
    
    // Обновление текста загаданного числа
    private func updateLabelWithSecretNumber(newText: String ) {
        label.text = newText
    }
    
    // Отображение всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
                        title: "Игра окончена",
                        message: "Вы заработали \(score) очков",
                        preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: { [self] _ in 
            let newSecretValue = game.startNewRound(withTryCounts: Config.tryGuessCountsEachRound)
            updateLabelWithSecretNumber(newText: String(newSecretValue))
        }))
        present(alert, animated: true, completion: nil)
    }
}


