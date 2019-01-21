Apipie.configure do |config|
  config.app_name                = "VirtualCurrency"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/doc"
  config.default_locale = 'ja'
  config.default_version = '1'
  config.languages = ['en', 'ja']
  config.markup = Apipie::Markup::Markdown.new
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
end