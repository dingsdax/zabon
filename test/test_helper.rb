# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "bundler/setup"
Bundler.require :tools

require "simplecov"
SimpleCov.start { enable_coverage :branch }

require "minitest/autorun"
require "minitest/pride"

require "zabon"

module Zabon
  def self.reset_config!
    @config = Configuration.new
  end
end
