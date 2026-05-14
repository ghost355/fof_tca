// CLI/main.swift
import AppCore
import AppEngine
import Foundation

@main
struct AppCLI {
    static func main() {
        var gameState = GameState()
        let reducer = AppReducer()
        let environment = GameEnvironment(actionDeck: MockActionDeck())
        var lastError = ""

        while true {
            renderScreen(state: gameState, lastError: lastError)
            lastError = ""

            guard let input = readLine() else {
                break
            }

            let parts = input.split(separator: " ")
            guard let choiceStr = parts.first, let choice = Int(choiceStr) else {
                lastError = "Неверный формат ввода. Введите число."
                continue
            }

            let action: GameAction
            switch choice {
            case 0:
                clearScreen()
                moveCursor(row: 1, col: 1)
                print("До свидания!")
                exit(0)
            case 1:
                guard parts.count == 2, let turns = Int(parts[1]) else {
                    lastError = "Использование: 1 <количество ходов>"
                    continue
                }
                action = .setup(.setMissionDuration(turns))
            case 2:
                action = .setup(.confirmSetup)
            default:
                lastError = "Неизвестная команда."
                continue
            }

            _ = reducer.reduce(state: &gameState, action: action, environment: environment)
        }
    }

    static func renderScreen(state: GameState, lastError: String) {
        clearScreen()
        hideCursor()

        let infoContent: [String] = [
            "Длительность миссии: \(state.setupState.missionDuration) ход(а/ов)"
        ]
        drawPanel(
            row: ScreenLayout.infoPanelRow,
            col: ScreenLayout.infoPanelCol,
            width: ScreenLayout.panelWidth,
            height: ScreenLayout.infoPanelHeight,
            title: " Состояние ",
            content: infoContent
        )

        let menuContent: [String] = [
            "1. Установить длительность миссии <число>",
            "2. Подтвердить подготовку (confirmSetup)",
            "0. Выход"
        ]
        drawPanel(
            row: ScreenLayout.menuPanelRow,
            col: ScreenLayout.menuPanelCol,
            width: ScreenLayout.panelWidth,
            height: ScreenLayout.menuPanelHeight,
            title: " Действия ",
            content: menuContent
        )

        moveCursor(row: ScreenLayout.inputRow, col: ScreenLayout.inputCol)
        setColor(text: .green)
        print("Введите команду > ", terminator: "")
        resetAttributes()
        showCursor()
        fflush(stdout)

        var helpContent = [
            "Подсказка: для установки длительности введите '1 12' (без кавычек)."
        ]
        if !lastError.isEmpty {
            helpContent.insert("ОШИБКА: \(lastError)", at: 0)
        }
        drawPanel(
            row: ScreenLayout.helpPanelRow,
            col: ScreenLayout.helpPanelCol,
            width: ScreenLayout.panelWidth,
            height: ScreenLayout.helpPanelHeight,
            title: " Сообщения ",
            content: helpContent
        )

        moveCursor(row: ScreenLayout.inputRow, col: ScreenLayout.inputPromptEnd)
        fflush(stdout)
    }
}
