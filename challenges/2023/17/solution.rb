# frozen_string_literal: true
module Year2023
  class Day17 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    require 'set'
    require 'algorithms'
    include Containers

    def parse
      data.map{_1.chars.map(&:to_i)}
    end

    @@opposite = {'u': 'd', 'l': 'r', 'd': 'u', 'r': 'l'}
    @@dirs = ['u', 'r', 'd', 'l'].each_with_index
    @@ddirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    def solve(min_dist, max_dist)
      map = parse
      max_r, max_c = map.size, map[0].size
      stop = [map.size-1, map[0].size-1]
      traversed = Set[]
      costs = {}

      # dist, r, c, last_dir
      queue = MinHeap.new([[0, 0, 0, '']])
      while queue.size > 0
        dist, r, c, dir = queue.min!

        if [r, c] == stop; return dist end
        if traversed.include?([r, c, dir]); next end

        traversed.add([r, c, dir])
        for new_dir, dir_idx in @@dirs
          # prevent go same line or turn back 180 after search
          if dir == new_dir or @@opposite[dir.to_sym] == new_dir; next end

          next_cost = 0
          for dist_mul in 1..max_dist
            nr, nc = [r, c].zip(@@ddirs[dir_idx]).map{_1 + (_2 * dist_mul)}

            if (0...max_r).include?(nr) and (0...max_c).include?(nc)
              next_cost += map[nr][nc]
              new_dist = dist + next_cost

              # skip the 1...min_dist
              if dist_mul < min_dist; next end
              # if the tile is traversed from different direction but with less cost, skip current candidate
              if costs.fetch([nr, nc, new_dir], Float::INFINITY) <= next_cost; next end
              costs[[nr, nc, new_dir]] = next_cost

              queue.push([new_dist, nr, nc, new_dir])
            end
          end
        end
      end

    end

    def part_1
      solve(1, 3)
    end

    def part_2
      solve(4, 10)
    end

  end
end
