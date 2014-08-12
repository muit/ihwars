class BaseController < ApplicationController
  #before_action :authenticate_user!
  def index
    @bases = []
    #@bases = current_user.bases
    if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
  end

  def createBase
    if (current_user.bases.length < Config.maxBases)
      current_user.bases.create(params[:name]);
      answerObject = {error: false, msg: ""}
    else
      answerObject = {error: true, msg: "Maximum bases reached."}
    end
    render :json => Packet.new(Opcode.BASE_CREATE, answerObject)
  end

end
