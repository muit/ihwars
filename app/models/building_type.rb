class BuildingType < ActiveRecord::Base
  def self.getAll
    @buildingTypes ||= self.all
  end

  def self.byTypeId(type_id)
    by(:type_id, type_id)
  end

  def self.by(argument, value)
    @buildingTypes ||= self.all
    @buildingTypes.select{|buildingType| buildingType[argument] == value}
  end
end
