//
//  ViewController.swift
//  Right on target
//
//  Created by USOV Vasily
//

import UIKit

class ViewController: UIViewController {
    
    // Сущность "Игра"
    private var game = {
        let generator = Generator(range: 1...50)
        return Game(generator: generator, rounds: 5)
    }()
    
    // Элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    
    // MARK: - Жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()

        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue))
    }
    
    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        game.calculateScore(withRoundScore: Int(slider.value))
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // Начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue))
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
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


