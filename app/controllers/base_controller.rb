class BaseController < ApplicationController
  before_action :authenticate_user!

  def index
    @bases = current_user.bases
    if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
  end

  def create
    puts "Creating a #{current_user.name}´s base"
    if current_user.bases.count >= Settings::MAX_BASES
      answerObject = {error: true, msg: "Maximum bases reached."}
    elsif !isValidBaseName?(params[:name])
      answerObject = {error: true, msg: "That name may be repeated or is empty."}
    else
      current_user.bases << Base.create(name: params[:name]);
      answerObject = {error: false, msg: ""}
    end
    render :json => Packet.new(Opcode::BASE_CREATE, answerObject)
  end

  def info
    selectedBase = getBase(params[:actualBase]);
    if(selectedBase == nil)
      answerObject = {error: true, msg: "That base doesnt exists."}
    else
      #Get entities
      entities = selectedBase.entity_stacks
      entityHash = entities.map{|entity| {type_id: entity.type_id, name: EntityType.byTypeId(entity.type_id).name, amount: entity.amount}}
      #Get buildings
      buildings = selectedBase.get_building_info

      answerObject = {error: false, entities: entityHash, buildings: buildings}
    end
    render :json => Packet.new(Opcode::BASE_INFO, answerObject)
  end

  def resources
    result = []
    ResourceType.getAll.each do |resource|
      amount = 0
      current_user.bases.all.each do |base|
        amount += base.resource_stacks.where(type_id: resource[:type_id])
      end
      result[resource[:type_id]] = amount
    end
    answerObject = {error: false, resources: result}
    render :json => Packet.new(Opcode::RESOURCE_INFO, answerObject)
  end

  

  private
  def isValidBaseName?(name)
    sameNameBase = getBase(name)
    puts sameNameBase == nil
    (name!="" && sameNameBase == nil)
  end

  def isValidBuildingId?(id)
    BuildingType.byTypeId(id) != nil
  end
end
