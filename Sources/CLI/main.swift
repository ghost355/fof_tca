// CLI/main.swift

import AppCore
import AppEngine
import Darwin

// 1. Начальное состояние игры — структура, которую мы будем менять через редьюсер
var state = GameState()

// 2. Главный редьюсер, который знает, как обрабатывать GameAction
let reducer = AppReducer()

// 3. Окружение с заглушкой колоды действий (пока не используется)
let environment = GameEnvironment(actionDeck: MockActionDeck())

print("=== Fields of Fire CLI ===")
print("Текущее состояние: \(state)")

// 4. Главный цикл: запрашиваем действие, применяем, показываем новое состояние
while true {
    print("\nДоступные действия:")
    print("1. setMissionDuration <количество ходов>")
    print("2. confirmSetup")
    print("0. Выйти")
    print("Ваш выбор: ", terminator: "")

    // readLine() возвращает String? — если поток ввода закрыт, выходим
    guard let input = readLine() else {
        break
    }

    let parts = input.split(separator: " ")
    guard let choiceStr = parts.first, let choice = Int(choiceStr) else {
        print("Неверный ввод. Введите число.")
        continue
    }

    // 5. Преобразуем выбор пользователя в GameAction
    let action: GameAction
    switch choice {
    case 0:
        exit(0)
    case 1:
        guard parts.count == 2, let turns = Int(parts[1]) else {
            print("Использование: 1 <число ходов>")
            continue
        }
        action = .setup(.setMissionDuration(turns))
    case 2:
        action = .setup(.confirmSetup)
    default:
        print("Неизвестное действие")
        continue
    }

    // 6. Вызываем редьюсер, который изменяет state и возвращает Effect
    let effect = reducer.reduce(state: &state, action: action, environment: environment)

    // 7. Выводим результат (эффект пока игнорируется, но видно, что он есть)
    print("Эффект: \(effect)")
    print("Новое состояние: \(state)")
}
