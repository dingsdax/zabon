# frozen_string_literal: true

# Minimal single-file Rails app demonstrating zabon.
#
# Usage:
#   bundle install
#   ruby app.rb
#   open http://localhost:3000            # English passthrough
#   open http://localhost:3000?locale=ja  # Japanese with zabon segmentation

require "bundler/setup"
require "rails"
require "action_controller/railtie"
require "zabon"

# ---------------------------------------------------------------------------
# 1. Configure zabon (optional — these are the defaults)
# ---------------------------------------------------------------------------
Zabon.configure do |config|
  config.tag         = :span
  config.tag_options = { class: "zabon", style: "display: inline-block" }
  config.strip_tags  = true
end

# ---------------------------------------------------------------------------
# 2. Optional Sentry integration
#    Add sentry-ruby + sentry-rails to the Gemfile to enable.
# ---------------------------------------------------------------------------
# if defined?(Sentry)
#   Sentry.init do |config|
#     config.dsn = ENV.fetch("SENTRY_DSN")
#     config.breadcrumbs_logger = [:active_support_logger]
#   end
# end

# ---------------------------------------------------------------------------
# 3. Controller — must be defined before App.initialize!
#    Include zabon_translate as a helper method. Use it explicitly in views
#    rather than overriding t() globally, which would affect all ActionView
#    translation calls.
#
#    To replace t() everywhere instead, alias the original first:
#      alias_method :translate_without_zabon, :translate
#      def translate(key, **options)
#        zabon_translate(key, orig_translate: :translate_without_zabon, **options)
#      end
#      alias t translate
# ---------------------------------------------------------------------------
class DemoController < ActionController::Base
  include Zabon::Helper
  helper_method :zabon_translate

  def index
    I18n.locale = params[:locale]&.to_sym || :en

    render inline: <<~HTML, layout: false
      <!DOCTYPE html>
      <html lang="<%= I18n.locale %>">
      <head>
        <meta charset="utf-8">
        <title>zabon demo</title>
        <style>
          body  { font-family: sans-serif; max-width: 640px; margin: 4rem auto; line-height: 2; }
          .zabon { display: inline-block; }
          nav a { margin-right: 1rem; }
        </style>
      </head>
      <body>
        <nav>
          <a href="/?locale=en">English</a>
          <a href="/?locale=ja">日本語</a>
        </nav>
        <h1><%= zabon_translate("greeting") %></h1>
        <p><%= zabon_translate("about") %></p>
        <hr>
        <details>
          <summary>Segments (locale: <%= I18n.locale %>)</summary>
          <pre><%= Zabon.split(I18n.t("about")).inspect %></pre>
        </details>
      </body>
      </html>
    HTML
  end
end

# ---------------------------------------------------------------------------
# 4. Application
# ---------------------------------------------------------------------------
class App < Rails::Application
  config.root = __dir__
  config.eager_load = false
  config.logger = Logger.new($stdout)
  config.log_level = :warn

  config.i18n.load_path += Dir[File.join(__dir__, "locales", "*.yml")]
  config.i18n.available_locales = %i[en ja]
  config.i18n.default_locale = :en
end

App.initialize!

App.routes.draw do
  root to: "demo#index"
end

# ---------------------------------------------------------------------------
# 5. Boot
# ---------------------------------------------------------------------------
require "rackup"
Rackup::Server.start(app: App, Port: 3000)
