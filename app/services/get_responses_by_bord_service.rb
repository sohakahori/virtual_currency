class GetResponsesByBordService
  def initialize params, board, per_page
    @params   = params
    @board    = board
    @per_page = per_page
  end

  def call
    get_response_by_bord
  end

  private
  attr_reader :params, :board, :per_page

  def get_response_by_bord
    responses = board.responses.includes(:user)
    responses = search_process responses
    responses.page(params[:page]).per(per_page)
  end

  def search_process responses
    responses = search_responses responses if params[:q].present? && params[:q][:response].present?
    responses = search_users responses if params[:q].present? && params[:q][:user].present?
    responses
  end

  def search_responses responses
    result_responses = nil
    params[:q][:response].split(" ").each_with_index do |word, i|
      if i == 0
        result_responses = responses.search_body(word).or(responses.search_id(word))
      else
        result_responses =  result_responses.or(responses.search_body(word).or(responses.search_id(word)))
      end
    end
    result_responses
  end

  # Todo: あえてarelを使用
  def search_users responses
    users_query = nil
    user_table = User.arel_table
    params[:q][:user].split(" ").each_with_index do |word, i|
      if i == 0
        users_query = user_table[:id].eq(word)
        users_query = users_query.or(user_table[:last_name].matches("%#{word}%"))
        users_query = users_query.or(user_table[:first_name].matches("%#{word}%"))
      else
        users_query = users_query.or(user_table[:id].eq(word))
        users_query = users_query.or(user_table[:last_name].matches("%#{word}%"))
        users_query = users_query.or(user_table[:first_name].matches("%#{word}%"))
      end
    end
    responses.where(user_id: User.where(users_query))
  end
end