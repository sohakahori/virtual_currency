module Api::V1::Filter::SetPageNumber
  extend ActiveSupport::Concern

  included do
    before_action :set_page_number, only: [:index]
  end

  def set_page_number
    params[:page] = params[:page][:number] if params[:page].present? && params[:page][:number].present?
  end
end