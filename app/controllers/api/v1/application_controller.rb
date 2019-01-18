class Api::V1::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include DeviseTokenAuth::Concerns::SetUserByToken
  include Api::V1::Filter::SetPageNumber
  include Api::V1::Filter::SetQueryStringToHash


  PER_PAGE = 30

  def render_error code, message, full_messages = nil
    render 'api/v1/base/error', formats: 'json', handlers: 'jbuilder', status: code, locals: { message: message, code: code, full_messages: full_messages }
  end


end
