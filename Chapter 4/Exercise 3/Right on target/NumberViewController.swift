import UIKit

class NumberViewController: UIViewController {
    
    enum Config {
        static let gameRounds = 5
    }
    
    // Экземпляр игры с числами
    var game = GameFactory.getNumericGame(withRounds: Config.gameRounds)
    
    // Элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var secretValueLabel: UILabel!
    
    // MARK: - Жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            // Показываем окно с итогами
            showAlertWith(score: game.score)
        } else {
            // Начинаем новый раунд игры
            game.startNewRound()
            // Обновляем данные о текущем значении загаданного числа
            updateLabelWithSecretNumber(newText: String(game.secretValue.value))
        }
    }
    
    // MARK: - Обновление View
    
    // Обновление текста загаданного числа
    func updateLabelWithSecretNumber(newText: String ) {
        secretValueLabel.text = newText
    }
    
    // Отображение всплывающего окна со счетом
    private func showAlertWith( score: Int ) {
        let alert = UIAlertController(
                        title: "Игра окончена",
                        message: "Вы заработали \(score) очков",
                        preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default) { [self] _ in
            // Рестартуем игру
            game.restartGame(withRounds: Config.gameRounds)
            // Обновляем данные о текущем значении загаданного числа
            updateLabelWithSecretNumber(newText: String(game.secretValue.value))
        })
        self.present(alert, animated: true, completion: nil)
    }
}

