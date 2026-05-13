// SetupReducer.swift

import AppCore

public struct SetupReducer: Reducer {
    public typealias State = SetupState
    public typealias Action = SetupAction
    public typealias Environment = GameEnviroment

    public init() {}

    public func reduce(
        state: inout SetupState,
        action: SetupAction,
        enviroment _: GameEnviroment
    ) -> Effect<SetupAction> {
        switch action {
        case let .selectCampaign(name):
            state.selectedCampaign = name
            return .none
        case let .selectMission(name):
            state.selectedMission = name
            return .none
        case let .placeUnit(placement):
            state.placeUnits.append(placement)
            return .none
        case let .removeUnit(unitID):
            state.placeUnits.removeAll { $0.unitID == unitID }
            return .none
        case .confirmSetup:
            // будет переход в фазу командования
            return .none
        }
    }
}
