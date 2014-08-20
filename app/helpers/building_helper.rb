module BuildingHelper
  def getLevelCost(base, buildingName, level)
    return nil if level == nil || level <= 0
    return nil if base == nil
    return nil if buildingName == nil || buildingName.length == 0

    cost = BuildingType.by(:type, buildingName).cost
    if level == 1
      return cost
    else
      return (cost*0.5*level*(1+Settings::COEF_PER_LEVEL)).round
    end
  end
end
