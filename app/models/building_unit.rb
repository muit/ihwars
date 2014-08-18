class BuildingUnit < ActiveRecord::Base
	belongs_to :base
  self.inheritance_column = :type
end
