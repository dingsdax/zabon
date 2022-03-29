# frozen_string_literal: true

require "zabon/analyzer"
require "zabon/configuration"
require "zabon/constants"
require "zabon/helper"
require "zabon/segment"
require "zabon/version"
require "zabon/railtie" if defined?(Rails::Railtie)

module Zabon
  class << self
    def split(text)
      Analyzer.segments(text)
    end

    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end