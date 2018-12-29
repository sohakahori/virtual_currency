class Public::ResponsesController < Public::ApplicationController
  before_action :authenticate_user!
  before_action :get_board, only: [:index, :new, :create]
  def index
    @responses = @board
                   .responses
                   .includes(:user)
                   .page(params[:page])
                   .per(RESPONSE_PER_PAGE)
  end

  def new
    @response = @board.responses.build
  end

  def create
    @response = @board.responses.build(response_params)
    @response.user = current_user
    if @response.save
      flash[:success] = "コメントを投稿しました"
      redirect_to public_board_responses_path(@board)
    else
      flash.now[:danger] = "入力値が不正です"
      render :new
    end
  end

  # Todo: /public/boards/:board_id/responses/id　のuriにする必要あり(エラーハンドリングを考慮した際)
  def destroy
    begin
      response = Response.find(params[:id])
      response.destroy!
    rescue => e
      flash[:danger] = "コメントを削除できませんでした"
      logger.error(e.message)
      redirect_back(fallback_location: public_board_responses_path(response.board)) and return
    end
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: public_board_responses_path(response.board)) and return
  end

  private
  def get_board
    @board = Board.find(params[:board_id])
  end

  def response_params
    params.require(:response).permit(:body)
  end
end
