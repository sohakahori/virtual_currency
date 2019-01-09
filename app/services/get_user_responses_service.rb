class GetUserResponsesService
  def initialize user, params
    @user   = user
    @params = params
  end

  def call
    get_user_responses
  end

  private
  attr_reader :user, :params
  def get_user_responses
    responses = user.responses.includes(:board)
    if params[:created_at].present?
      responses = responses.order_created_at params[:created_at]
    else
      responses = responses.order_created_at "desc"
    end
    responses.page(params[:page]).per(Public::ApplicationController::RESPONSE_PER_PAGE)
  end
end