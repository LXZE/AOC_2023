# frozen_string_literal: true
module Year2023
  class Day01 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    @@nums = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

    def part_1
      data.map { |l| l[/\d/] + l[/(?<digit>\d)\D*$/, :digit] }.map(&:to_i).sum
    end

    def part_2
      nums = @@nums
        .each_with_index.map { |str, idx| [str, (idx+1).to_s] }.to_h
      pattern = Regexp.new("(#{nums.keys.join('|')})")

      data.map {|l| l.sub(pattern, nums)}
        .map { |l| l[/\d/] }
        .zip(data.map {|l| sub_last l}
          .map { |l| l[/\d/] }
        )
        .map { |a| a.join().to_i }.sum
    end

    def sub_last(str)
      nums = @@nums.map(&:reverse)
        .each_with_index.map { |str, idx| [str, (idx+1).to_s] }.to_h
      pattern = Regexp.new("(#{nums.keys.join('|')})")
      return str.reverse.sub(pattern, nums)
    end
  end
end
