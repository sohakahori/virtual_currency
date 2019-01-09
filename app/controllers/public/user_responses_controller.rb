class Public::UserResponsesController < Public::ApplicationController
  before_action :authenticate_user!
  def index
    @responses = GetUserResponsesService.new(current_user, params).call
  end

  def destroy
    begin
      DeleteResponseService.new(current_user.responses.find(params[:id])).call
    rescue => e
      flash[:danger] = e.message
      redirect_back(fallback_location: public_user_responses_path) and return
    end
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: public_user_responses_path)
  end
end