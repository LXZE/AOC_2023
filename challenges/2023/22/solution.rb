# frozen_string_literal: true
module Year2023
  class Day22 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    require 'set'

    # @return [Array<Array<Integer>>]
    def parse
      data.map{|l| l.split('~').map{_1.split(',').map(&:to_i)}}.sort{|a,b| a[0][2] <=> b[0][2]}
    end

    def gen_range(a, b)
      if a[0] != b[0]
        (a[0]..b[0]).map{[_1, a[1], a[2]]}
      elsif a[1] != b[1]
        (a[1]..b[1]).map{[a[0], _1, a[2]]}
      else
        (a[2]..b[2]).map{[a[0], a[1], _1]}
      end
    end

    # @return [Hash<Set, Set>]
    def gen_stack()
      if $cache['stack']; return $cache['stack'] end

      bricks = parse.map{gen_range(*_1)}
      bricks_deps = Hash.new Set[]
      grid_max_z = Array.new(10){Array.new(10){0}}

      bricks.group_by{_1[0][2] == 1 ? :f : :a} => {f: on_floor, a: on_air}
      on_floor.each{|brick|
        bricks_deps[brick.to_set] = Set[]
        brick.each{|x,y,z| grid_max_z[x][y] = [grid_max_z[x][y], z].max}
      }

      on_air.each{|brick|
        found_dz = (1...(brick[0][2])).find {|dz|
          # check the max z that brick can't go down
          brick.map{|cube| [cube[0], cube[1], cube[2]-dz]}.any?{|x,y,z| grid_max_z[x][y] == z}
        }
        found_dz = brick[0][2] if found_dz.nil? # if floor then use self.z as dz
        brick.map!{|x,y,z| [x,y,z-found_dz+1]}

        under = brick.map{|x,y,z|
          bricks_deps.keys.find{_1.member? [x, y, z-1]}
        }.compact.to_set

        bricks_deps[brick.to_set] = under
        brick.each{|x,y,z| grid_max_z[x][y] = [grid_max_z[x][y], z].max}
      }

      $cache['stack'] = bricks_deps
    end

    def removable?(neighbor)
      if neighbor.size == 0
        true
      else
        neighbor.all?{_1.size > 1}
      end
    end

    def part_1
      bricks_lower = gen_stack
      bricks_lower.keys.sum{|brick|
        removable?(bricks_lower.values.select{_1.member? brick}) ? 1 : 0
      }
    end

    def part_2
      bricks_lower = gen_stack
      bricks_upper = bricks_lower.keys.map{|brick|
        [brick, bricks_lower.select{_2.member? brick}.keys]
      }.to_h

      bricks_lower.keys.sum{|brick|
        removed = Set[brick]
        to_remove_bricks = bricks_upper[brick]
        while (candidate = to_remove_bricks.shift)
          # skip except some below bricks are not removed
          next if bricks_lower[candidate].any? {not removed.include?(_1)}
          removed << candidate
          to_remove_bricks += bricks_upper[candidate]
        end
        removed.size - 1
      }
    end

  end
end
