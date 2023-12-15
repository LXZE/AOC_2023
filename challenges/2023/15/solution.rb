# frozen_string_literal: true
module Year2023
  class Day15 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      @input.chomp.split(/,/)
    end

    def hash(str)
      str.codepoints.reduce(0){((_1 + _2)*17)%256}
    end

    def part_1
      parse.map{hash _1}.sum
    end

    def part_2
      reg = Array.new(256){{}}
      parse.each{|cmd|
        case cmd[-1]
        when '-'
          key = cmd[..-2]
          reg[hash key].delete key
        else
          key, val = cmd.split('=')
          reg[hash key][key] = val.to_i
        end
      }
      reg.map.with_index(1){|dict, i| dict.values.map.with_index(1){i*_1*_2}.sum}.sum
    end

  end
end
