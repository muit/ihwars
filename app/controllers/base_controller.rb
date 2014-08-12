class BaseController < ApplicationController
  #before_action :authenticate_user!
  def index
    if mobile_device?
      render :mobile, layout: "mobile"
    else
      render :desktop, layout: "desktop"
    end
  end
end