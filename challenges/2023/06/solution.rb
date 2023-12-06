# frozen_string_literal: true
module Year2023
  class Day06 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map{|l| l.scan(/\d+/).map(&:to_i)}.transpose
    end

    def parse2
      data.map{|l| l.scan(/\d+/).join('')}.map(&:to_i)
    end

    def calc(time, dist)
      (1...time).count{|t| (time-t)*t > dist}
    end

    def part_1
      parse.map{|p|calc(*p)}.inject(:*)
    end

    def part_2; calc(*parse2) end
  end
end
