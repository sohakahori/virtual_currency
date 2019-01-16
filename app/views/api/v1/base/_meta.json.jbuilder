json.set! :meta do
  json.total_pages collection.total_pages
  json.current_page collection.current_page
  json.total_count collection.total_count
  json.limit_value collection.limit_value
  json.links do
    json.pages! collection, url: url_for(only_path: false), query_parameters: @query_strings
  end
end
