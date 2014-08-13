class Hub < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 0
    super(arguments)
  end
end