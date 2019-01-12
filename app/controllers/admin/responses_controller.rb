class Admin::ResponsesController < Admin::ApplicationController

  before_action :get_board, only: [:index, :show]

  def index
    @params = params
    @responses = GetResponsesByBordService.new(params, @board, Admin::ApplicationController::PER_PAGE).call
  end

  def show
    @response = Response.find(params[:id])
  end

  def destroy
    begin
      response = Response.find(params[:id])
      response.destroy!
    rescue => e
      logger.error(e.message)
      flash[:danger] = "コメントの削除に失敗しました"
      redirect_back(fallback_location: admin_board_response_path(params[:board_id], response))
    end
    flash[:success] = "コメントを削除しました"
    redirect_to admin_board_responses_path(params[:board_id])
  end

  private
  def get_board
    @board = Board.find(params[:board_id])
  end
end
