# frozen_string_literal: true

module Zabon
  Configuration = Struct.new(:tag, :tag_options, :strip_tags, keyword_init: true) do
    def initialize(tag: :span, tag_options: { class: "zabon", style: "display: inline-block" }, strip_tags: true)
      super
    end
  end
end
