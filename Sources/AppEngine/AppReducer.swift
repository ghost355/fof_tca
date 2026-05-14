// AppReducer.swif

import AppCore

public struct AppReducer: Reducer {
    public typealias State = GameState
    public typealias Action = GameAction
    public typealias Environment = GameEnvironment

    private let setupReducer = SetupReducer()

    public init() {}

    public func reduce(
        state: inout GameState,
        action: GameAction,
        environment: GameEnvironment
    ) -> Effect<GameAction> {
        switch action {
        case let .setup(setupAction):
            return setupReducer.reduce(
                state: &state.setupState,
                action: setupAction,
                environment: environment
            ).map { GameAction.setup($0) }
        }
    }
}
