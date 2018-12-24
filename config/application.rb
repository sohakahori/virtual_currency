require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module VirtualCurrency
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # miniテスト作成しない
    config.generators do |g|
      g.test_framework false
    end

    config.i18n.default_locale = :ja

    # ja.ymlファイル等を起動時に読み込む
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end

    # 表示時のタイムゾーンをJSTに設定
    config.time_zone = 'Tokyo'
    # DB保存時のタイムゾーンをJSTに設定
    config.active_record.default_timezone = :local
  end
end
