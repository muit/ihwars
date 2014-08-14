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
    elsif !isValidName?(params[:name])
      answerObject = {error: true, msg: "That name may be reapeated or is empty."}
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

  private
  def isValidBaseName?(name)
    mapsWithSameName = current_user.bases.map {|base| base.name == name}
    (name!="" && mapsWithSameName.length <= 0)
  end
  def isValidBuildingId?(id)
    Cache.building(id) != nil
  end
end
