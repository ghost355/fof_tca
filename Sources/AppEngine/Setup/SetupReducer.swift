// SetupReducer.swift

import AppCore

public struct SetupReducer: Reducer {
    public typealias State = SetupState
    public typealias Action = SetupAction
    public typealias Environment = GameEnvironment

    public init() {}

    public func reduce(
        state: inout SetupState,
        action: SetupAction,
        environment _: GameEnvironment
    ) -> Effect<SetupAction> {

        switch action {

        case let .setMissionDuration(turns):
            state.missionDuration = turns
            return .none

        case .confirmSetup:
            // будет переход в фазу командования
            return .none
        }
    }
}
