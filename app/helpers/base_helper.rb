module BaseHelper
  def hasFactories?(base)
    base.building_units.where(type: "Factory").count >= 1
  end

  def isValidBaseName?(name)
    sameNameBase = getBase(name)
    puts sameNameBase == nil
    (name!="" && sameNameBase == nil)
  end
end
