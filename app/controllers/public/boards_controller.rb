class Public::BoardsController < Public::ApplicationController

  before_action :authenticate_user!

  def index
  end

  def new
    @board = Board.new
    @board.responses.build
  end

  def create
    @board = current_user.boards.build(board_params)
    @board.responses[0].user = current_user
    if @board.save
      flash[:success] = "スレッドを作成しました"
      redirect_to new_public_board_path
    else
      flash.now[:danger] = "不正な入力値です"
      render :new
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, responses_attributes: [:body])
  end

end
