class Api::V1::BoardsController < Api::V1::ApplicationController
  before_action :authenticate_user!

  def index
    @boards = GetBoardsService.new(params).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
