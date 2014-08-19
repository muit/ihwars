module BaseHelper
  def hasFactories?(base)
    current_user.building_stacks.where(type: "Factory").count >= 1
  end
end
