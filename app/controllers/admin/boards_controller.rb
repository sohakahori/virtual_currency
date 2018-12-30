class Admin::BoardsController < Admin::ApplicationController
  def index
    @q = params[:q]
    @boards = Board.includes(:user)
    if @q.present?
      @boards = @boards.includes(:responses).references(:responses)
      search_process
    end
    @boards = @boards.page(params[:page]).per(PER_PAGE)
  end

  def destroy
    begin
      board = Board.find(params[:id])
      board.destroy!
    rescue => e
      logger.error(e.message)
      flash[:danger] = "スレッドの削除に失敗しました"
      redirect_back(fallback_location: admin_boards_path) and return
    end
    flash[:success] = "スレッドを削除しました"
    redirect_back(fallback_location: admin_boards_path) and return
  end

  private
  def search_process
    boards = @q.split(" ").map do |q|
      @boards.search_title(q).or(@boards.merge(Response.search_body(q)))
    end
    boards.each_with_index do |board, i|
      if i == 0
        @boards = board
      else
        @boards = @boards.or(board)
      end
    end
  end
end
