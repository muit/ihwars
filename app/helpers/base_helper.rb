module BaseHelper
  def hasFactories?(base)
    base.building_units.where(type: "Factory").count >= 1
  end
end
