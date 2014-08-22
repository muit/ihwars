class EntityType < ActiveRecord::Base
  #Model for all the entity types
  #This won´t be used like objects! 
  def self.getAll
    @entityTypes ||= self.order("type_id")
  end

  def self.byTypeId(type_id)
    by(:type_id, type_id)
  end

  def self.by(argument, value)
    @entityTypes ||= self.order("type_id")
    @entityTypes.select{|entityType| entityType[argument] == value}.first
  end

end
