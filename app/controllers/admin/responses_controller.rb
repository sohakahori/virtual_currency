class Admin::ResponsesController < Admin::ApplicationController

  before_action :get_board, only: [:index, :show]

  def index
    @responses = @board.responses.includes(:user)
    search_process
    @responses = @responses.page(params[:page]).per(PER_PAGE)
  end

  def show
    @response = Response.find(params[:id])
  end

  def get_board
    @board = Board.find(params[:board_id])
  end

  private # Todo: 要リファクタリング
  def search_process
    @q = {}
    if params[:q].present?
      @q[:response] = params[:q][:response]
      @q[:user]     = params[:q][:user]
    else
      @q[:response] = nil
      @q[:user]     = nil
    end

    if @q[:response].present?
      search_responses
    end
    if @q[:user].present?
      @responses = @responses.references(:users)
      search_users
    end
  end

  def search_responses
    q_responses = @q[:response].split(" ").map do |q_response|
      @responses.search_id(q_response).or(@responses.search_body(q_response))
    end
    q_responses.each_with_index do |response, i|
      if i == 0
        @responses = response
      else
        @responses = @responses.or(response)
      end
    end
  end

  def search_users
    q_users = @q[:user].split(" ").map do |q_user|
      @responses.merge(User.search_id(q_user).or(User.search_no_space_full_name(q_user)))
    end

    q_users.each_with_index do|user, i|
      if i == 0
        @responses = user
      else
        @responses = @responses.or(user)
      end
    end
  end
end
