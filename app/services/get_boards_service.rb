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
    boards = Board
    if params[:q].present?
      boards = boards.includes(:responses).references(:responses)
      boards = search_process boards
    end
    boards.page(params[:page]).per(ApplicationController::PER_PAGE)
  end

 def search_process boards
   result_boards = nil
   params[:q].split(/[[:blank:]]+/).each_with_index do |word, i|
     if i == 0
       result_boards = boards.search_title(word).or(boards.merge(Response.search_body(word)))
     else
       result_boards = result_boards.or(boards.search_title(word).or(boards.merge(Response.search_body(word))))
     end
   end
   result_boards
 end
end