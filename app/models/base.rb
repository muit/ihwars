class Base < ActiveRecord::Base
  belongs_to :entityStack
  belongs_to :buildingStack
end
