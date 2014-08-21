class Resources
  # 1=60s/2=30s
  def initialize speed
    #Disable ActiveRecord Log
    Settings.enable_AR_log(false);

    Base.all.each do |base|
      addResources(base, speed)
    end
    Settings.enable_AR_log(true);
    puts "Resources updated successfully."
  end

  def addResources(base, speed)
    ActiveRecord::Base.transaction do
      Cache.building_resources.each do |link|
        totalIncrement = 0
        productionSpeed = BuildingType.byTypeId(link[:building_id]).productsxMinute

        base.building_units.where(type_id: link[:building_id]).each do |building|
          totalIncrement += (productionSpeed+productionSpeed*building.level*Settings::COEF_PER_LEVEL)/speed
        end

        resource_stack = base.resource_stacks.where(type_id: link[:resource_id])[0]
        resource_stack.amount += totalIncrement
        resource_stack.save
      end
    end
  end
end