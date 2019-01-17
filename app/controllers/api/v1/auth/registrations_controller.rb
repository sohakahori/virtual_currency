class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  protect_from_forgery with: :null_session

private
  def sign_up_params
    params.permit(:first_name, :last_name, :nickname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.permit(:first_name, :last_name, :nickname, :email)
  end
end
