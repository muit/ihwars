class Barracks < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 4
    super(arguments)
  end
end