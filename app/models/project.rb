class Project < ActiveRecord::Base
  has_many :entries
  validates :name, uniqueness: true, presence: true
  
  def self.iron_find(value)
    p = Project.find_by_id value
    raise "There´s no any insert for that id." unless p
    p
  end

  def total_hours_in_month(month, year)
    totalHours = 0;
    month = Date.new(year, month, 1)
    queryEntries = entries.where(date: month..month.end_of_month)
    puts queryEntries
    queryEntries.each do |entry|
      totalHours +=  entry.hours + entry.minutes/60.0
    end    
    totalHours.round(2)
  end
end
