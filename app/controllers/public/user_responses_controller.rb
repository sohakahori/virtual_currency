class Public::UserResponsesController < Public::ApplicationController
  before_action :authenticate_user!
  def index
    @responses = current_user.responses.includes(:board)
    @responses.order_created_at params[:created_at] if params[:created_at].present?
    @responses = @responses.page(params[:page]).per(RESPONSE_PER_PAGE)
  end
end
