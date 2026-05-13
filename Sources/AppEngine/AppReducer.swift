// AppReducer.swif

import AppCore

public struct AppReducer: Reducer {
    public typealias State = GameState
    public typealias Action = GameAction
    public typealias Environment = GameEnviroment

    private let setupReducer = SetupReducer()

    public init() {}

    public func reduce(state: inout GameState,
                       action: GameAction,
                       enviroment: GameEnviroment) -> Effect<GameAction>
    {
        switch action {
        case let .setup(setupAction):
            return setupReducer.reduce(
                state: &state.setupState,
                action: setupAction,
                enviroment: enviroment
            ).map { GameAction.setup($0) }
        }
    }
}
