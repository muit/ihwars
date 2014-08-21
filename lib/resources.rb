class Resources
  def initialize
    #Disable ActiveRecord Log
    Settings.enable_AR_log(false);

    Base.all.each do |base|
      addResources(base)
    end
    Settings.enable_AR_log(true);
    puts "Resources updated successfully."
  end

  def addResources(base)
    ActiveRecord::Base.transaction do
      Cache.building_resources.each do |link|
        totalIncrement = 0
        productionSpeed = BuildingType.byTypeId(link[:building_id]).productsxMinute

        base.building_units.where(type_id: link[:building_id]).each do |building|
          totalIncrement += productionSpeed+productionSpeed*building.level*Settings::COEF_PER_LEVEL
        end

        resource_stack = base.resource_stacks.where(type_id: link[:resource_id])[0]
        resource_stack.amount += totalIncrement
        resource_stack.save
      end
    end
  end
end