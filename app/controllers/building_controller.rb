class BuildingController < ApplicationController
  before_action :authenticate_user!
  def new
    if isValidBuildingId?(params[:type_id])
      selectedBase = getBase(params[:actualBase])

      finish_building = Time.now+Cache.building(0)[:construction_time].seconds
      selectedBase.building_units.create(type_id: params[:type_id], finish_building: finish_building, level: 1)
      
      answerObject = {error: false, msg: "", finish_building: finish_building}
    else
      answerObject = {error: true, msg: "There was an invalid type_id."}
    end
    render :json => Packet.new(Opcode.BUILDING_CREATE, answerObject)
  end

  def update
    selectedBase = getBase(params[:actualBase])
    building = selectedBase.building_units.find(params[:id])

    seconds = Cache.building(0)[:construction_time].seconds
    finish_building = Time.now+(seconds+seconds*building.level*Settings.coefPerLevel)
    building.finish_building = finish_building
    building.level += 1
    building.save
    answerObject = {finish_building: finish_building}
    render :json => Packet.new(Opcode.BUILDING_UPDATE, answerObject)
  end

  def info
    selectedBase = getBase(params[:actualBase]);
    building_units = selectedBase.building_units.where(type_id: params[:type_id])
    buildingHash = clearBuildings building_units
    answerObject = {error: false, msg: "", buildings: buildingHash}

    render :json => Packet.new(Opcode.BUILDING_INFO, answerObject)
  end

  private

  def clearBuildings buildings
    buildings.map{|building| {id: building.id, type_id: building.type_id, level: building.level, builded_at: building.finish_building}}
  end

  def getBuildingModel(type_id)

  end
end
