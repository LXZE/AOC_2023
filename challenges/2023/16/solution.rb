# frozen_string_literal: true
module Year2023
  class Day16 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    require 'set'


    def parse
      data.map(&:chars)
    end

    @@cache = {}
    @@dir_map = {
      'u': [-1, 0], 'd': [+1, 0],
      'l': [0, -1], 'r': [0, +1],
    }

    def find_next(current, map)
      if @@cache.has_key?(current); return @@cache[current] end

      r, c, dir = current
      nr, nc = [r, c].zip(@@dir_map[dir.to_sym]).map(&:sum)

      if !(0...map.size).include?(nr) or !(0...map[0].size).include?(nc)
        return []
      end

      next_tile = map.dig(nr, nc)
      res = case next_tile
      when '.'; [dir]
      when '/'
        case dir
        when 'u'; ['r']
        when 'r'; ['u']
        when 'l'; ['d']
        when 'd'; ['l']
        end
      when '\\'
        case dir
        when 'u'; ['l']
        when 'l'; ['u']
        when 'r'; ['d']
        when 'd'; ['r']
        end
      when '|'
        ['u','d'].include?(dir) ? [dir] : ['u', 'd']
      when '-'
        ['l','r'].include?(dir) ? [dir] : ['l', 'r']
      end.map{[nr, nc, _1]}
      @@cache[current] ||= res
      res
    end

    def solve(start, map)
      traversed = Set[]
      beams = [start]
      while beams.size > 0
        beams.map!{find_next(_1, map)}.flatten!(1).filter!{!traversed.member?(_1)}
        beams.each{traversed.add(_1)}
      end
      traversed.group_by{_1[..1]}.keys.count
    end

    def part_1
      solve([0, -1, 'r'], parse)
    end

    def part_2
      map = parse
      max_r, max_c = map.size, map[0].size
      [
        *(0...max_r).to_a.map{[_1, -1, 'r']},
        *(0...max_r).to_a.map{[_1, max_c, 'l']},
        *(0...max_c).to_a.map{[-1, _1, 'd']},
        *(0...max_c).to_a.map{[max_r, _1, 'u']},
      ].map{solve(_1, map)}.max
    end

  end
end
