module Api::V1::Filter::SetQueryStringToHash
  extend ActiveSupport::Concern

  included do
    before_action :set_query_string_to_hash, only: [:index]
  end

  def set_query_string_to_hash
    @query_strings = Rack::Utils.parse_nested_query(URI.parse(request.url).query)
  end
end