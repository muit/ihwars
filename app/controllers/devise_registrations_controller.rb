class DeviseRegistrationsController < Devise::RegistrationsController
	# Override the superclass's methods to add custom params
	
	
  private
 
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
