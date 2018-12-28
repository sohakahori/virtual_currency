class Public::BoardsController < Public::ApplicationController

  before_action :authenticate_user!

  def index
    @q      = params[:q]
    @boards = Board
    if @q.present?
      @boards = @boards.includes(:responses).references(:responses)
      @boards = @boards.search_title(@q).or(@boards.merge(Response.search_body(@q)))
    end
    @boards = @boards.page(params[:page]).per(PER_PAGE)
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
      redirect_to public_boards_path
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
