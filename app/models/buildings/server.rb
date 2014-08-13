class Server < BuildingUnit
  def create(arguments)
    arguments[:type_id] = 1
    super(arguments)
  end
end