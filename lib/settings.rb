class Settings
  MAX_BASES = 5
  COEF_PER_LEVEL = 0.25
  INITIAL_ENTITY_SIZE = 30
  INITIAL_RESOURCE_MONEY = 5000
  INITIAL_RESOURCE_MATERIALS = 20000
  INITIAL_RESOURCE_PING = 0

  def self.enable_AR_log value
    if(!value)
      @old_logger = ActiveRecord::Base.logger
      ActiveRecord::Base.logger = nil
    else
      ActiveRecord::Base.logger = @old_logger
    end
  end
end