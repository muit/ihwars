class Bank < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 6
    super(arguments)
  end
end