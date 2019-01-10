module Admin::ResponsesHelper
  def get_response_param
    @params[:q].present? && @params[:q][:response].present? ? @params[:q][:response] : nil
  end

  def get_user_param
    @params[:q].present? && @params[:q][:user].present? ? @params[:q][:user] : nil
  end
end
