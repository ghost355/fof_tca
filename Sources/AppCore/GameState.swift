// GameState.swift

public struct GameState: Equatable {
    public var setupState: SetupState

    public init(setupState: SetupState = SetupState()) {
        self.setupState = setupState
    }
}
