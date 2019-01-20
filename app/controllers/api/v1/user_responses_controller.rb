class Api::V1::UserResponsesController < Api::V1::ApplicationController

  def index
    @responses = GetUserResponsesService.new(current_user, params).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
