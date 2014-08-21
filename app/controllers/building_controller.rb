class BuildingController < ApplicationController
  before_action :authenticate_user!
  def create
    typeId = params[:type_id].to_i
    baseName = params[:actualBase]
    opcode = Opcode::BUILDING_CREATE


    return if watch_error(opcode, !isValidBuildingId?(typeId), "There was an invalid type_id.")
    
    selectedBase = getBase(baseName)
    return if watch_error(opcode, selectedBase.building_units.where(type_id: typeId).length >= 1, "You can´t build same building two times!")

    
    return if watch_error(opcode, selectedBase == nil, "The selected base does not exist!")

    puts typeId

    cost = BuildingType.byTypeId(typeId).cost
    baseMaterials = selectedBase.resource_stacks.find_by_type_id(1)
    return if watch_error(opcode, cost > baseMaterials.amount, "You dont have enought materials!")

    baseMaterials.amount -= cost
    baseMaterials.save

    finish_building = Time.now+BuildingType.byTypeId(typeId).construction_time.seconds

    selectedBase.building_units.create(type: BuildingType.byTypeId(typeId).name, type_id: typeId, finish_building: finish_building, level: 1)
    

    answerObject = {error: false, msg: "", finish_building: finish_building}
    render :json => Packet.new(opcode, answerObject)
  end

  def update
    selectedBase = getBase(params[:actualBase])
    building = selectedBase.building_units.find_by_type_id(params[:type_id].to_i)

    seconds = BuildingType.byTypeId(building.type_id).construction_time.seconds
    finish_building = Time.now+(seconds+seconds*(building.level+1)*Settings::COEF_PER_LEVEL)
    
    building.finish_building = finish_building
    building.level += 1
    building.save
    answerObject = {finish_building: finish_building}

    render :json => Packet.new(Opcode::BUILDING_UPDATE, answerObject)
  end

  def info
    selectedBase = getBase(params[:actualBase])
    building_units = selectedBase.building_units.where(type_id: params[:type_id].to_i)
    buildingHash = clearBuildings building_units
    answerObject = {error: false, msg: "", buildings: buildingHash}

    render :json => Packet.new(Opcode::BUILDING_INFO, answerObject)
  end

  def cost
    cost = get_level_cost_by_type(params[:type_id].to_i, params[:level].to_i)
    answerObject = {error: false, msg: "", cost: cost}

    render :json => Packet.new(Opcode::BUILDING_INFO, answerObject)
  end

  private

  def clearBuildings buildings
    buildings.map{|building| {id: building.id, type_id: building.type_id, level: building.level, builded_at: building.finish_building}}
  end

  def get_level_cost_by_name(buildingName, level)
    return nil if level == nil || level <= 0
    return nil if buildingName == nil || buildingName.length == 0

    cost = BuildingType.by(:name, buildingName).cost
    if level == 1
      return cost
    else
      return (cost*0.5*(level-1)*(1+Settings::COEF_PER_LEVEL)).round
    end
  end

  def get_level_cost_by_type(buildingType, level)
    return nil if level == nil || level <= 0
    return nil if buildingType == nil || buildingType < 0

    cost = BuildingType.byTypeId(buildingType).cost
    if level == 1
      return cost
    else
      return (cost*0.5*(level-1)*(1+Settings::COEF_PER_LEVEL)).round
    end
  end

  def isValidBuildingId?(id)
    BuildingType.byTypeId(id) != nil
  end

  def watch_error(opcode, condition, msg)
    if(condition)
      render :json => Packet.new(opcode, {error: true, msg: msg})
    end
    condition
  end
end
