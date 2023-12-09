# frozen_string_literal: true
module Year2023
  class Day09 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def find_next(array)
      next_arr = array[1..].zip(array[..-2]).map{_1-_2}
      array.all?(&:zero?) ? 0 : array[-1] + find_next(next_arr)
    end

    def parse
      data.map{|l| l.split(' ').map(&:to_i)}
    end

    def part_1
      parse.map{find_next(_1)}.sum
    end

    def part_2
      parse.map{find_next(_1.reverse)}.sum
    end

  end
end
