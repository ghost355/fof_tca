// Core.swift

public protocol Reducer {
    associatedtype State
    associatedtype Action
    associatedtype Environment

    func reduce(
        state: inout State,
        action: Action,
        environment: Environment
    ) -> Effect<Action>
}

public struct Effect<Action> {
    public static var none: Effect {
        Effect()
    }

    public func map<NewAction>(_: @escaping (Action) -> NewAction) -> Effect<NewAction> {
        .none
    }
}
