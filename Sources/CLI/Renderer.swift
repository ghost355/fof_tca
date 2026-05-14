// CLI/Renderer
import Foundation

enum ScreenLayout {
    static let panelWidth = 100
    static let leftMargin = 2

    static let infoPanelRow = 1, infoPanelCol = leftMargin
    static let infoPanelHeight = 8

    static let menuPanelRow = 10, menuPanelCol = leftMargin
    static let menuPanelHeight = 7

    static let inputRow = 18, inputCol = leftMargin
    static let inputPromptEnd = 20

    static let helpPanelRow = 20, helpPanelCol = leftMargin
    static let helpPanelHeight = 5
}

// MARK: - ANSI helpers

func clearScreen() {
    print("\u{001B}[2J", terminator: "")
}

func moveCursor(row: Int, col: Int) {
    print("\u{001B}[\(row);\(col)H", terminator: "")
}

func hideCursor() {
    print("\u{001B}[?25l", terminator: "")
}

func showCursor() {
    print("\u{001B}[?25h", terminator: "")
}

enum ANSIColor: Int {
    case black = 30, red, green, yellow, blue, magenta, cyan, white
    case brightBlack = 90, brightRed, brightGreen, brightYellow, brightBlue, brightMagenta, brightCyan, brightWhite
}

extension ANSIColor {
    var background: Int { rawValue + 10 }
}

func setColor(text: ANSIColor? = nil, background: ANSIColor? = nil) {
    var codes = [String]()
    if let t = text { codes.append("\(t.rawValue)") }
    if let b = background { codes.append("\(b.background)") }
    if !codes.isEmpty {
        print("\u{001B}[\(codes.joined(separator: ";"))m", terminator: "")
    }
}

func resetAttributes() {
    print("\u{001B}[0m", terminator: "")
}

func drawHorizontalLine(length: Int) {
    print(String(repeating: "─", count: length), terminator: "")
}

func drawPanel(row: Int, col: Int, width: Int, height: Int, title: String, content: [String]) {
    moveCursor(row: row, col: col)
    print("┌", terminator: "")
    drawHorizontalLine(length: width - 2)
    print("┐", terminator: "")

    moveCursor(row: row, col: col + 1)
    setColor(text: .white, background: .blue)
    print(title, terminator: "")
    resetAttributes()

    for i in 0..<(height - 2) {
        moveCursor(row: row + 1 + i, col: col)
        print("│", terminator: "")
        if i < content.count {
            moveCursor(row: row + 1 + i, col: col + 1)
            print(content[i], terminator: "")
            let contentLength = content[i].count
            let padding = width - 2 - contentLength
            if padding > 0 {
                print(String(repeating: " ", count: padding), terminator: "")
            }
        } else {
            print(String(repeating: " ", count: width - 2), terminator: "")
        }
        moveCursor(row: row + 1 + i, col: col + width - 1)
        print("│", terminator: "")
    }

    moveCursor(row: row + height - 1, col: col)
    print("└", terminator: "")
    drawHorizontalLine(length: width - 2)
    print("┘", terminator: "")
}
