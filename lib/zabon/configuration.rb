# frozen_string_literal: true

module Zabon
  class Configuration
    attr_accessor :tag, :tag_options, :strip_tags

    def initialize
      # HTML tag & options used for wrapping segments
      @tag = :span
      @tag_options = { class: "zabon", style: "display: inline-block" }

      # strip source string of HTML tags; e.g. if source string does already contain span tags
      @strip_tags = true
    end
  end
end
