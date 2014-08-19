class ResourceType < ActiveRecord::Base
	def self.getAll
    @resourceTypes ||= self.all
  end

  def self.byTypeId(type_id)
    by(:type_id, type_id)
  end

  def self.by(argument, value)
    @resourceTypes ||= self.all
    @resourceTypes.select{|resourceType| resourceType[argument] == value}.first
  end
end