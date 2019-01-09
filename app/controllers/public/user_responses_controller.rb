class Public::UserResponsesController < Public::ApplicationController
  before_action :authenticate_user!
  def index
    @responses = GetUserResponsesService.new(current_user, params).call
  end
end