class GetBoardsService
   def initialize params
     @params = params
   end

   def call
     get_boards
   end

  private
  attr_reader :params

  def get_boards
    boards = Board.includes(:user)
    if params[:q].present?
      boards = boards.includes(:responses).references(:responses)
      boards = search_process boards
    end
    boards.page(params[:page]).per(Admin::ApplicationController::PER_PAGE)
  end

 def search_process boards
   search_boards = params[:q].split(" ").map do |q|
     boards.search_title(q).or(boards.merge(Response.search_body(q)))
   end
   search_boards.each_with_index do |search_board, i|
     if i == 0
       boards = search_board
     else
       boards = boards.or(search_board)
     end
   end
   boards
 end
end