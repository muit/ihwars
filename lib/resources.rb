class Resources
  def initialize
    puts "Updating Resources..."
    Base.all.each do |base|
      puts "    #{base.user.name}..."
      addResources(base)
    end
    puts "Resources updated successfully."
  end

  def addResources(base)
    ActiveRecord::Base.transaction do
      Cache.building_resources.each do |link|
        totalIncrement = 0
        productionSpeed = Cache.building(link[:building_id])[:productsxMinute]

        base.building_units.where(type_id: link[:building_id]).each do |building|
          totalIncrement += productionSpeed+productionSpeed*building.level*Settings.coefPerLevel
        end

        resource_stack = base.resource_stacks.where(type_id: link[:resource_id])[0]
        resource_stack.amount += totalIncrement
        resource_stack.save
      end
    end
  end
end