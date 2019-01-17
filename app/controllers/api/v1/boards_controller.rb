class Api::V1::BoardsController < Api::V1::ApplicationController
  before_action :authenticate_user!


  def index
    @boards = GetBoardsService.new(params).call
    @query_strings = get_query_string_to_hash
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
