# frozen_string_literal: true
module Year2023
  class Day18 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map{_1.split(' ')}
    end

    @@ddirs = {'U': [-1, 0], 'R': [0, 1], 'D': [1, 0], 'L': [0, -1]}

    def calc_area(points)
      area = perim = r = c = 0
      points.each{|dir, size|
        perim += size
        dr, dc = @@ddirs[dir.to_sym]
        nr, nc = [r+(dr*size), c+(dc*size)]
        # shoelace formula (calculate inner area)
        area += (c*nr) - (r*nc) # c as x, r as y (order is important in this case)
        r, c = nr, nc
      }
      (area/2 + perim/2 + 1).abs # pick's theorem
    end

    def part_1
      calc_area parse.map{[_1, _2.to_i]}
    end

    @@dir = %w(R D L U)

    def part_2
      calc_area parse.map{[@@dir[_3[-2].to_i], _3[2..-3].to_i(16)]}
    end

    # brute force
    # require 'set'
    # def part_1
    #   return nil
    #   plans = parse
    #   traversed = Set[[0, 0]]
    #   pos = [0, 0]
    #   plans.each{|dir, size_s, _|
    #     size = size_s.to_i
    #     case dir
    #     when 'U'
    #       for nr in (pos[0]-1).downto(pos[0]-size)
    #         pos[0] = nr
    #         traversed.add(pos.clone)
    #       end
    #     when 'R'
    #       for nc in (pos[1]+1).upto(pos[1]+size)
    #         pos[1] = nc
    #         traversed.add(pos.clone)
    #       end
    #     when 'D'
    #       for nr in (pos[0]+1).upto(pos[0]+size)
    #         pos[0] = nr
    #         traversed.add(pos.clone)
    #       end
    #     when 'L'
    #       for nc in (pos[1]-1).downto(pos[1]-size)
    #         pos[1] = nc
    #         traversed.add(pos.clone)
    #       end
    #     end
    #   }
    #   # expand
    #   queue =[[1, 1]]
    #   min_r, min_c, max_r, max_c = 0, 0, 0, 0
    #   traversed.each{|r, c|
    #     min_r, max_r = [min_r, max_r, r].minmax
    #     min_c, max_c = [min_c, max_c, c].minmax
    #   }

    #   inside = Set[]
    #   queue = [[1, 1]]
    #   while queue.size > 0
    #     tile = queue.shift
    #     inside.add(tile)
    #     candidates = @@ddirs.map{_1.zip(tile).map{|e, de| e+de}}
    #       .filter{(min_r..max_r).include?(_1[0]) and (min_c..max_c).include?(_1[1])}
    #       .reject{traversed.include?(_1) or queue.include?(_1) or inside.include?(_1)}
    #     queue.push(*candidates)
    #   end
    #   p traversed.size + inside.size
    # end

  end
end
