class Public::ApplicationController < ApplicationController
  protect_from_forgery with: :exception

  layout "public"

  PER_PAGE = 30
end
