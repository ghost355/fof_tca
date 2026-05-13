// SetupAction.swift

public enum SetupAction: Equatable {
    case selectCampaign(String)
    case selectMission(String)
    case placeUnit(UnitPlacement)
    case removeUnit(unitID: String)
    case confirmSetup
}
