class Factory < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 3
    super(arguments)
  end
end