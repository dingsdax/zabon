# frozen_string_literal: true

require "action_view"

module Zabon
  module Helper
    include ActionView::Helpers::TagHelper

    # can be used as a replacement for ActionView::Helpers::TranslationHelper.translate
    # will use original translate method if locale is not :ja or translation is missing
    # if not will split translation into semantic chunks wrap them into a configurable HTML tag
    # and join again
    def zabon_translate(key, **options)
      orig_translate = options[:orig_translate] || :translate

      locale = (options[:locale] || I18n&.locale || :en).to_sym

      return public_send(orig_translate, key, **options) if locale != :ja # if locale is not Japanese we use original method

      return key.map { |k| zabon_translate(k, **options) } if key.is_a?(Array)

      orig_translation = public_send(orig_translate, key, **options)

      return orig_translation if orig_translation.include?("translation_missing")

      orig_translation = strip_tags(orig_translation) if Zabon.config.strip_tags

      translation = Zabon.split(orig_translation).map do |segment|
        content_tag(Zabon.config.tag, segment, Zabon.config.tag_options)
      end.join.html_safe

      block_given? ? yield(translation, key) : translation
    end
  end
end
