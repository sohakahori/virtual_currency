class Api::V1::ResponsesController < Api::V1::ApplicationController

  before_action :authenticate_user!
  before_action :get_board
  def index
    @responses = GetResponsesByBordService.new(params, @board, Api::V1::ApplicationController::PER_PAGE).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    @response      = @board.responses.build(response_params)
    @response.user = current_user
    if @response.save
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render_error Settings.status_code.bad_request, Settings.status_message.bad_request, @response.errors.full_messages
    end
  end

  def destroy
    begin
      @response = @board.responses.find(params[:id])
      render_error Settings.status_code.bad_request, Settings.status_message.bad_request and return unless @response.user_id == current_user.id
      @response.destroy!
    rescue => e
      render_error Settings.status_code.internal_server_error, e.message and return
    end
    render 'destroy', formats: 'json', handlers: 'jbuilder'
  end

  private
  def get_board
    begin
      @board = Board.find(params[:board_id])
    rescue => e
      render_error Settings.status_code.internal_server_error, e.message
    end
  end

  def response_params
    params.require(:response).permit(:body)
  end
end
