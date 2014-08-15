class BuildingController < ApplicationController
  def info
    selectedbase = getBase(params[:actualBase]);
    building_units = selectedBase.building_units.where(type_id: params[:type_id])
    buildingHash = clearBuildings building_units
    answerObject = {error: false, msg: "", buildings: buildingHash}

    render :json => Packet.new(Opcode.BUILDING_INFO, answerObject)
  end

  private

  def clearBuildings buildings
    buildings.map{|building| {type_id: building.type_id, level: building.level, builded_at: building.finish_building}}
  end
end
