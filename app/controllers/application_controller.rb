class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_coins_path
    when User
      public_coins_path
  end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :user
      new_user_session_path
    end
  end

  PER_PAGE = 30
end
