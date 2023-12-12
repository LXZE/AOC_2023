# frozen_string_literal: true

$cache = {}
module Year2023
  class Day12 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map{|l|
        spring, group = l.split(' ')
        group = group.split(',').map(&:to_i)
        [spring, group]
      }
    end

    # brute force
    # def is_match?(str, count)
    #   str.gsub('.', ' ').squeeze(' ').strip.split(' ').map(&:size) == count
    # end
    # def generate(str)
    #   unknown = str.count('?')
    #   (0...1<<unknown).to_a.map{|i|
    #     res = str.clone
    #     substr = i.to_s(2).rjust(unknown, '.').gsub('1', '#').gsub('0', '.')
    #     for ch in substr.each_char
    #       res.sub!('?', ch)
    #     end
    #     res
    #   }
    # end

    # @param str [String]
    # @param nums [Integer[]]
    def search(str, nums)
      # p [str, nums]
      if $cache.has_key? [str, nums]; return $cache[[str, nums]] end
      if nums.size == 0
        return (str.nil? or !str.include?('#')) ? 1 : 0
      end

      expected_size = nums[0]
      result = 0

      # check observation (window) is match and next step is still valid until current is sharp
      for idx in 0...(str.nil? ? '' : str).size
        if idx + expected_size < str.size and # observe size still in range
          !str[idx...(idx+expected_size)].include?('.') and # window must not include "."
          (str[idx + expected_size] != '#') # next char after window must not start with "#"
          # idx+size+1 for proceed to search next group
          result += search(str[(idx + expected_size + 1)..], nums[1..])
        end
        # allow only '.' or '?' to proceed
        if str[idx] == '#' then break end
      end

      $cache[[str, nums]] ||= result
      result
    end

    def part_1
      parse.map{|str, count|
        search(str + '.', count)
      }.sum
    end

    def part_2
      parse.map{|str, count|
        search(([str]*5).join('?') + '.', count*5)
      }.sum
    end

  end
end
