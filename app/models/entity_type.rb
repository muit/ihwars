class EntityType < ActiveRecord::Base
  #Model for all the entity types
  #This won´t be used like objects! 
  def self.getAll
    @entityTypes ||= self.all
  end

  def self.byTypeId(type_id)
    by(:type_id, type_id)
  end

  def self.by(argument, value)
    @entityTypes ||= self.all
    @entityTypes.select{|entityType| entityType[argument] == value}
  end

end
