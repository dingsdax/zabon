# frozen_string_literal: true

require "rails/railtie"
require "action_view"

module Zabon
  class Railtie < Rails::Railtie
    initializer "zabon.helper" do
      ActionView::Base.include Zabon::Helper
    end
  end
end
