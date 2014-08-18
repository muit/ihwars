class DeviseSessionsController < Devise::SessionsController
  after_filter :after_login, :only => :create

	def after_login
		flash[:cookies] = "Al usar este sitio web aceptas el uso de cookies."
  end
end