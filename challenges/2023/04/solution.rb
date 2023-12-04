# frozen_string_literal: true
module Year2023
  class Day04 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map {|l|
        l.split(': ')[1]
          .split(' | ')
          .map { |pack| pack.split(' ').map(&:to_i) }
      }
    end

    def count(nums_win, nums_have)
      nums_win.filter { |n| nums_have.include?(n) }.size
    end

    def score(nums_win, nums_have)
      count = count(nums_win, nums_have)
      count > 0 ? 1<<(count-1) : 0
    end

    def part_1
       parse().map {|pair| score(*pair)}.sum
    end

    def part_2
      counter = Hash.new(0)
      parse().each.with_index(1) {|pair, idx|
        if counter[idx] == 0
          counter[idx] = 1
        else
          counter[idx] += 1
        end
        for i in idx+1..idx+count(*pair)
          counter[i] += counter[idx]
        end
      }
      counter.values.sum
    end

  end
end
