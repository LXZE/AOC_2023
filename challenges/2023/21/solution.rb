# frozen_string_literal: true
module Year2023
  class Day21 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    require 'set'
    require 'matrix'

    # @return [Array<Array<String>>]
    def parse
      data.map{_1.chars}
    end

    # u r d l
    @@dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    def get_neighbors(r, c, max_r, max_c)
      @@dirs.map{|dir|
        [r,c].zip(dir).map(&:sum)
      }.select{|nr, nc| (0...max_r).include?(nr) and (0...max_c).include?(nc)}
    end

    def part_1
      map = parse
      start_point = [0, 0]
      for row, r in map.each_with_index
        for elem, c in row.each_with_index
          if elem == 'S'; start_point = [r, c]; break end
        end
      end
      max_r, max_c = map.size, map[0].size
      t = ENV['RB_ENV'] == 'test' ? 6 : 64
      poss = Set[start_point]
      t.times.each {
        poss = Set[*poss.flat_map{get_neighbors(*_1, max_r, max_c)}.filter{|r,c| map[r][c] != '#'}]
      }
      poss.size
    end

    def get_duplicate(map); Marshal.load(Marshal.dump map) end
    def expand_map(map) # expand outward for 2 grids: 1x1 -> 5x5
      new_rows = Array.new(5){Matrix[*(get_duplicate map)]}.reduce(&:hstack).to_a
      Array.new(5){Matrix[*(get_duplicate new_rows)]}.reduce(&:vstack).to_a
    end

    def part_2 # not work with example as it doesn't have empty start row and col
      map = parse
      start_point = [0, 0]
      h, w = map.size, map[0].size

      for row, r in map.each_with_index
        for elem, c in row.each_with_index
          if elem == 'S'
            start_point = [r, c]
            map[r][c] = '.'
            break
          end
        end
      end

      # h == w
      new_start_point = [h, w].map{_1*2}.zip(start_point).map(&:sum)

      expanded_map = expand_map map
      eh, ew = expanded_map.size, expanded_map[0].size

      num, rem = 26501365.divmod(map.size)

      poss = Set[new_start_point]
      traversed = Set[new_start_point]
      odds = Set[]

      # steps amount that reach the end of expanded map
      (rem + (h*2)).times.each{|t|
        poss = Set[
          *poss.flat_map{get_neighbors(*_1, eh, ew)}
            .filter{|r,c| expanded_map[r][c] != '#' and !traversed.member?([r,c]) }
        ]
        traversed.merge(poss)
        if t%2 == 0; odds.merge(poss) end
      }
      counter = Hash.new 0
      odds.each{|r,c| counter[[r/h, c/w]] += 1}

      # in input data, steps expand in diamond shape because of empty start row and col
      # calculate only tips on each directions,
      # edges of diamonds (outer and inner)
      # and middle grids (center and non center)
      tips = [[0, 2], [2, 0], [2, 4], [4, 2]].map{counter.dig(_1)}.sum
      edge_outer = [[0, 1], [1, 4], [3, 0], [4, 3]].map{counter.dig(_1)}.sum
      edge_inner = [[1, 1], [1, 3], [3, 1], [3, 3]].map{counter.dig(_1)}.sum
      center = counter.dig([2, 2])
      notcenter = counter.dig([2, 3])
      tips \
      + (edge_outer * num) \
      + (edge_inner * (num-1)) \
      + (notcenter  * (num ** 2)) \
      + (center     * ((num-1) ** 2))
    end

  end
end
