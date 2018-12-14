class Admin::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  layout 'admin'
  before_action :authenticate_admin!

  PER_PAGE= 30
end
