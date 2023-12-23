# frozen_string_literal: true
module Year2023
  class Day23 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map(&:chars)
    end

    require 'set'
    require 'algorithms'
    include Containers

    @@dirs = ['u', 'r', 'd', 'l']
    @@ddirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    @@invalid_tile = %w[v < ^ >]

    def dfs(r, c, dist, traversed, const)
      stop, h, w, grid = const
      return nil if traversed.member?([r, c])
      traversed << [r, c]
      return dist if [r, c] == stop

      next_params = []
      rr, cc, dd = r, c, dist
      traversed = traversed.clone
      inner_traversed = traversed.clone
      loop do
        return dd if [rr, cc] == stop

        next_params = @@ddirs.zip(@@invalid_tile).map {|((dr, dc), forbid_tile)|
          nr, nc = [rr, cc].zip([dr, dc]).map(&:sum)
          next unless (0...h).include?(nr) and (0...w).include?(nc)
          next if ['#', forbid_tile].include? grid.dig(nr, nc)
          next if inner_traversed.member?([nr, nc])
          [nr, nc, dd+1]
        }.compact
        return nil if next_params.size == 0
        ( traversed << [rr, cc]; break ) if next_params.size > 1
        rr, cc, dd = next_params[0]
        inner_traversed << [rr, cc]
      end

      next_params.map {|nr, nc, nd|
        dfs(nr, nc, nd, traversed.clone, const) || 0
      }.max
    end

    def part_1
      grid = parse
      start = [0, 1]
      h, w = grid.size, grid[0].size
      stop = [h - 1, w - 2]

      dfs(*start, 0, Set[], [stop, h, w, grid])
    end

    class Graph
      def initialize
        @edges = Hash.new {|h,k| h[k] = Set[]}
        @dist = Hash.new 0
      end
      def add_edge(u, v, d)
        @dist[[u, v]] = d
        @dist[[v, u]] = d
        @edges[u] << v
        @edges[v] << u
      end

      def neighbors(u); @edges[u] end
      def distance(u, v); @dist[[u, v]] end
    end

    def get_neighbors(r, c, (h, w, grid))
      @@ddirs.map {|(dr, dc)|
        nr, nc = [r, c].zip([dr, dc]).map(&:sum)
        next unless (0...h).include?(nr) and (0...w).include?(nc)
        next if grid.dig(nr, nc) == '#'
        [nr, nc]
      }.compact
    end

    def solve_part2(grid)
      start = [0, 1]
      h, w = grid.size, grid[0].size
      stop = [h - 1, w - 2]

      nodes = Set[start, stop]
      for r in 1...grid.size
        for c in 1...grid[0].size
          next if grid[r][c] == '#'
          nodes << [r, c] if @@ddirs.count {grid.dig(*_1.zip([r,c]).map(&:sum)) == '.'} >= 3
        end
      end

      g = Graph.new

      nodes.each{|node|
        # p "check node #{node}"
        dist = {node => 0}
        q = [node]
        while (cnode = q.shift) # candidate node
          # p "next candidate node #{cnode}"
          for neighbor in get_neighbors(*cnode, [h, w, grid])
            next if dist.has_key? neighbor
            if nodes.include? neighbor # if found next node
              g.add_edge(node, neighbor, dist[cnode] + 1)
              next
            end
            dist[neighbor] = dist[cnode] + 1
            q += [neighbor]
          end
        end
      }

      # BRUTE FORCEEEEEEEEEEEEEEEEEE
      res = 0
      visited = Set[start]
      q = [[start, visited, 0]]
      while (node, seen, cost = q.shift)
        (res = [res, cost].max; next) if node == stop
        for neighbor in g.neighbors(node)
          next if seen.include? neighbor
          q.push([neighbor, seen | [neighbor], cost + g.distance(node, neighbor)])
        end
      end
      res
    end

    def part_2
      grid = parse
      grid.map!{|row| row.map{['#','.'].include?(_1) ? _1 : '.'}}
      solve_part2 grid
    end

  end
end
