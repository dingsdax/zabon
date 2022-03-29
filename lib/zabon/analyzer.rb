# frozen_string_literal: true

module Zabon
  class Analyzer
    class << self
      def split(text)
        text.split(KEYWORDS)
            .flat_map { |segment| segment.split(JOSHI) }
            .flat_map { |segment| segment.split(BRACKETS_BEGIN) }
            .flat_map { |segment| segment.split(BRACKETS_END) }
            .flatten.reject(&:empty?)
      end

      def segments(text)
        result = [""] # we do this, so we can += to append to the last result item, without checking for nil
        previous_segment = nil

        split(text).each do |segment|
          current_segment = Segment.new(segment)

          # if the current segment is a beginning bracket => we look further
          if current_segment.bracket_begin?
            previous_segment = current_segment
            next
          end

          # if the current segment is an ending bracket =>
          # we append to the last entry of the result set and don't look back anymore,
          # we've reached the end of a segment and start a new one with the next iteration
          if current_segment.bracket_end?
            result[-1] += current_segment
            previous_segment = nil
            next
          end

          # if the previous segment is a beginning bracket =>
          # we stitch together previous segment & current segment tp become a new segment
          # we don't look back anymore
          if previous_segment&.bracket_begin?
            current_segment = Segment.new(previous_segment + current_segment)
            previous_segment = nil
          end

          # if we don't look at the first segment, the current segment is a particle or a period and
          # we are not looking back, we append to the last entry of the result set
          if result.size > 1 && current_segment.joshi_or_period? && previous_segment.nil?
            result[-1] += current_segment
            previous_segment = current_segment
            next
          end

          # if we are not at the start, the current segment is a particle or a period or
          # the previous segment is not a bracket or period or a conjunctive particle and the current segment is hiragana
          # we append to the last entry of the result set
          if result.length > 2 && current_segment.joshi_or_period? || (previous_segment&.keyword? && current_segment.hiragana? && !/^[とのに]$/.match?(previous_segment))
            result[-1] += current_segment
            # if the current segment is not a particle, we are no looking back anymore, we start a new segment
            previous_segment = current_segment.joshi? ? current_segment : nil
            next
          end

          # no stitching left, append the current segment to the result set
          result << current_segment
          previous_segment = current_segment
        end

        result.reject(&:empty?) # we clear out any possible blank strings in the result set
      end
    end
  end
end
