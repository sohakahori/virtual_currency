class Api::V1::ResponsesController < Api::V1::ApplicationController

  before_action :authenticate_user!
  def index
    begin
      @board = Board.find(params[:board_id])
    rescue => e
      render_error Settings.status_code.internal_server_error, "board_idに紐づくboardを取得できませんでした" and return
    end
    @responses = GetResponsesByBordService.new(params, @board, Api::V1::ApplicationController::PER_PAGE).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
