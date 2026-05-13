// SetupState.swift

public struct SetupState: Equatable {
    public var selectedCampaign: String?
    public var selectedMission: String?
    public var placeUnits: [UnitPlacement] = []

    public init() {}
}

public struct UnitPlacement: Equatable {
    public var unitID: String
    public var coordinate: GridCoordinate

    public init(unitID: String, coordinate: GridCoordinate) {
        self.unitID = unitID
        self.coordinate = coordinate
    }
}

public struct GridCoordinate: Equatable {
    public var x: Int
    public var y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
