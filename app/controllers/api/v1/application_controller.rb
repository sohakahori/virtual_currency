class Api::V1::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include DeviseTokenAuth::Concerns::SetUserByToken
  include Api::V1::Filter::SetPageNumber


  def get_query_string_to_hash
    Rack::Utils.parse_nested_query(URI.parse(request.url).query)
  end

  def render_error code, message
    render 'api/v1/base/error', formats: 'json', handlers: 'jbuilder', status: code, locals: { message: message, code: code }
  end
end
