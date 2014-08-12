class Base < ActiveRecord::Base
  has_many :entityStack
  has_many :buildingStack
  belongs_to :user
end
