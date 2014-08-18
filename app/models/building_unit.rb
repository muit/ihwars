class BuildingUnit < ActiveRecord::Base

  HUB_ID = 0

	belongs_to :base
  self.inheritance_column = :type
end
