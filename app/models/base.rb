class Base < ActiveRecord::Base
  has_many :entityStack
  has_many :buildingUnit
  has_many :resourceStack
  belongs_to :user
end
