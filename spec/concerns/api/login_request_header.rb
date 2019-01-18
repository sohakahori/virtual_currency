module Api::LoginRequestHeader
  extend ActiveSupport::Concern

  included do
    def token_sign_in
      user.create_new_auth_token
    end
  end
end