# frozen_string_literal: true
module Year2023
  class Day13 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      @input.split(/\n\n/).map{|e|e.split(/\n/)}
    end

    def transpose(map)
      map.map{_1.split('')}.transpose.map{_1.join('')}
    end

    # @param map [String[String[]]]
    def find_pos(map)
      res = []
      lim_r = map.size-1
      for r in 0...lim_r # [..-2]
        if r.downto(0).zip((r+1).upto(lim_r))
          .reject{_1.any?(&:nil?)}
          .all?{|ru, rd| map[ru] == map[rd]}
          res.push(r+1)
        end
      end
      res
    end

    def solve(map)
      find_pos(map).map{_1 * 100}.push(*find_pos(transpose(map)))
    end

    def part_1
      parse.map{solve(_1)[0]}.sum
    end

    def edit_map(map, (r, c))
      new_map = Marshal.load(Marshal.dump(map))
      new_map[r][c] = map[r][c] == '#' ? '.' : '#'
      new_map
    end

    def part_2
      parse.map{|m|
        ans = nil
        default_ans = solve(m)[0]
        Enumerator.product(0...m.size, 0...m[0].size).each{|edit_pos|
          s_map = edit_map(m, edit_pos)
          # pp s_map
          res = solve(s_map).filter{_1 != default_ans}[0]
          if res; ans = res; break end
        }
        # if ans.nil?; raise 'no result!' end
        ans
      }.sum
    end

  end
end
