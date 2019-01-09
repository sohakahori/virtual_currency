class GetBoardsByResponsesService

  def initialize responses
    @responses = responses
  end

  def call
    getBoards
  end

  private
  attr_reader :responses

  def getBoards
    boards = responses.includes(:board).map do |response|
      response.board
    end
    boards.uniq.unshift Board.new
  end
end