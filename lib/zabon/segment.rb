# frozen_string_literal: true

module Zabon
  class Segment < String
    def hiragana?
      @hiragana ||= HIRAGANA.match(self)
    end

    def keyword?
      @keyword ||= KEYWORDS.match?(self)
    end

    def bracket_begin?
      @bracket_begin ||= BRACKETS_BEGIN.match?(self)
    end

    def bracket_end?
      @bracket_end ||= BRACKETS_END.match?(self)
    end

    def joshi?
      @joshi ||= JOSHI.match?(self)
    end

    def period?
      @period ||= PERIODS.match?(self)
    end

    def joshi_or_period?
      @joshi_or_period ||= (joshi? || period?)
    end
  end
end
