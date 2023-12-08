# frozen_string_literal: true
module Year2023
  class Day08 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      inst, _, *lookup = data
      lookup = lookup.map{ |l|
        key, vals = l.split(' = ')
        [key, vals.scan(/\w{3}/)]
      }.to_h
      [inst, lookup]
    end

    def part_1
      inst, lookup = parse
      current = 'AAA'
      step = 0
      inst.split('').cycle { |cmd|
        if current == 'ZZZ' then break end
        current = lookup[current][cmd == 'L' ? 0 : 1]
        step += 1
      }
      step
    end

    def part_2
      inst, lookup = parse
      current = lookup.keys.filter{|k| k[-1] == 'A'}
      found = lookup.keys.filter{|k| k[-1] == 'Z'}.map{|k| [k, 0]}.to_h
      step = 0
      inst.split('').cycle { |cmd|
        if found.values.all? {|f| f != 0} then break end
        current.filter{|c| c[-1] == 'Z' and found[c] == 0}.each{|c| found[c] = step}
        current.map!{ |c| lookup[c][cmd == 'L' ? 0 : 1] }
        step += 1
      }
      found.values.inject(&:lcm)
    end

  end
end
