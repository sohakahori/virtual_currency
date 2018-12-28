class Public::ResponsesController < Public::ApplicationController
  before_action :authenticate_user!
  before_action :get_board, only: [:index, :new, :create]
  def index
    @responses = @board.responses.page(params[:page]).per(RESPONSE_PER_PAGE) # Todo 検索処理　ソート処理
  end

  def new

  end

  def create

  end

  def destroy
  end

  private
  def get_board
    @board = Board.find(params[:board_id])
  end
end
