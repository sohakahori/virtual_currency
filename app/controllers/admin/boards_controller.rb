class Admin::BoardsController < Admin::ApplicationController
  def index
    @q = params[:q]
    @boards = GetBoardsService.new(params).call
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
end
