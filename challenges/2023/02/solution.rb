# frozen_string_literal: true
module Year2023
  class Day02 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    @@regex_r = /(?<r>(\d+) red)/
    @@regex_g = /(?<g>(\d+) green)/
    @@regex_b = /(?<b>(\d+) blue)/

    def is_possible(r, g, b)
      if r <= 12 and g <= 13 and b <= 14
        return true
      end
      return false
    end

    def part_1
      return data.each_with_index.map {
        |l, idx| l
          .split(': ')[1]
          .split('; ')
          .all? {
            |play| is_possible(
              (play[@@regex_r, :r] || '0').split(' ')[0].to_i,
              (play[@@regex_g, :g] || '0').split(' ')[0].to_i,
              (play[@@regex_b, :b] || '0').split(' ')[0].to_i
            )
          } ? idx + 1 : 0
      }.sum
    end

    def part_2
      return data.map {
        |l|
          max_r = max_g = max_b = 0
          l.split(': ')[1]
          .split('; ')
          .each {
            |play|
              max_r = [max_r, (play[@@regex_r, :r] || '0').split(' ')[0].to_i].max
              max_g = [max_g, (play[@@regex_g, :g] || '0').split(' ')[0].to_i].max
              max_b = [max_b, (play[@@regex_b, :b] || '0').split(' ')[0].to_i].max
          }
          [max_r, max_g, max_b].reduce(1, &:*)
        }.sum
    end
  end
end
