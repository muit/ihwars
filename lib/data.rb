class Data

  #Entity adapter
  def entity(type_id)
    Entity.where(type_id: type_id)[0]
  end

  #Building adapter
  def building(type_id)
    Building.where(type_id: type_id)[0]
  end
end