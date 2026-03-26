# frozen_string_literal: true

module Zabon
  class Segment < String
    def hiragana? = @hiragana ||= HIRAGANA.match?(self)
    def keyword? = @keyword ||= KEYWORDS.match?(self)
    def bracket_begin? = @bracket_begin ||= BRACKETS_BEGIN.match?(self)
    def bracket_end? = @bracket_end ||= BRACKETS_END.match?(self)
    def joshi? = @joshi ||= JOSHI.match?(self)
    def period? = @period ||= PERIODS.match?(self)
    def joshi_or_period? = @joshi_or_period ||= joshi? || period?
  end
end
