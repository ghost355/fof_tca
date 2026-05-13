// ActionDeck.swift

public protocol ActionDeck {
    // draw() -> ([ActionCard], ActionDeck)
}

public struct MockActionDeck: ActionDeck {
    public init() {}
}
