class Entry < ActiveRecord::Base
  belongs_to :project
  validates :hours, :minutes, numericality: { message: "Not a number."}
end
