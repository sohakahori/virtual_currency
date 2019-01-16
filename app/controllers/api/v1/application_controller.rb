class Api::V1::ApplicationController < ApplicationController
  # protect_from_forgery with: :exception

  def errors code, message
    render 'api/v1/base/error', formats: 'json', handlers: 'jbuilder', status: code, locals: { message: message }
  end
end
