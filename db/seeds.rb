# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Project.create(name: "KillingPandas", description: "Social activities to kill pandas")

200.times do |i|
  puts "KillingPandas_#{i}"
  p = Project.create(name: "KillingPandas_#{i}", description: "Social activities to kill pandas number #{i}")
  Random.rand(50...100).times do |e|
    date = Date.new(2014, Random.rand(1...12), Random.rand(1...29))
    puts "    Entry_#{date}"
    p.entries.create(date:  date, hours: Random.rand(0...8), minutes: Random.rand(1...59), comment: "Entry_#{e}")
  end
end

