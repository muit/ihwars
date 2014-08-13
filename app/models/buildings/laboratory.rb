class Laboratory < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 5
    super(arguments)
  end
end