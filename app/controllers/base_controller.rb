class BaseController < ApplicationController
  #before_action :authenticate_user!
  def index
    @bases = current_user.bases
    if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
  end

  def create
    puts "Creando Base a #{current_user.name}"
    #Settings.maxBases
    if current_user.bases.count >= 5
      answerObject = {error: true, msg: "Maximum bases reached."}
    elsif !isValidBaseName?(params[:name])
      answerObject = {error: true, msg: "That name may be repeated or is empty."}
    else
      current_user.bases.create(name: params[:name]);
      answerObject = {error: false, msg: ""}
    end
    render :json => Packet.new(Opcode.BASE_CREATE, answerObject)
  end

  def build
    if isValidBuildingId?(params[:id])
      current_user.bases.create(params[:name]);
      answerObject = {error: false, msg: ""}
    else
      answerObject = {error: true, msg: "Maximum bases reached."}
    end
    render :json => Packet.new(Opcode.BASE_CREATE, answerObject)
  end

  def info
    selectedBase = getBase(params[:actualBase]);
    #Get entities
    entities = selectedBase.getEntities
    entityHash = entities.map{|entity| {type_id: entity.type_id, amount: entity.amount}}
    #Get buildings
    buildings = selectedBase.getBuildingAmounts

    answerObject = {entityAmount: entityHash, buildingAmount: buildings}
    render :json => Packet.new(Opcode.BASE_INFO, answerObject)
  end

  private
  def isValidBaseName?(name)
    sameNameBase = getBase(name)
    (name!="" && sameNameBase != nil)
  end
  def isValidBuildingId?(id)
    Cache.building(id) != nil
  end
end
