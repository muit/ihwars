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
    #Settings.maxBases
    if current_user.bases.count >= 5
      answerObject = {error: true, msg: "Maximum bases reached."}
    elsif !isValidBaseName?(params[:name])
      answerObject = {error: true, msg: "That name may be repeated or is empty."}
    else
      current_user.bases << Base.create(name: params[:name]);
      answerObject = {error: false, msg: ""}
    end
    render :json => Packet.new(Opcode.BASE_CREATE, answerObject)
  end

  def build
    
    render :json => Packet.new(Opcode.BASE_CREATE, answerObject)
  end

  def info
    selectedBase = getBase(params[:actualBase]);
    if(selectedBase == nil)
      answerObject = {error: true, msg: "That base doesnt exists."}
    else
      #Get entities
      entities = selectedBase.getEntities
      entityHash = entities.map{|entity| {type_id: entity.type_id, name: Cache.entity(entity.type_id)[:name], amount: entity.amount}}
      #Get buildings
      buildings = selectedBase.getBuildingAmounts

      answerObject = {error: false, entities: entityHash, buildings: buildings}
    end
    render :json => Packet.new(Opcode.BASE_INFO, answerObject)
  end

  def resources
    result = []
    Cache.resources.each do |resource|
      amount = 0
      current_user.bases.all.each do |base|
        amount += base.resource_stacks.where(type_id: resource[:type_id])
      end
      result[resource[:type_id]] = amount
    end
    answerObject = {error: false, resources: result}
    render :json => Packet.new(Opcode.RESOURCE_INFO, answerObject)
  end

  private
  def isValidBaseName?(name)
    sameNameBase = getBase(name)
    puts sameNameBase == nil
    (name!="" && sameNameBase == nil)
  end
  def isValidBuildingId?(id)
    Cache.building(id) != nil
  end
end
