# frozen_string_literal: true
module Year2023
  class Day10 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file
    require 'paint'
    require 'set'
    $traversed = Set[]

    @@news = [[-1, 0, 'N'], [0, 1, 'E'], [0, -1, 'W'], [1, 0, 'S']]

    def get_possible_pipes(current, dir)
      possible_pipes = { N: '|F7', E: '-J7', W: '-LF', S: '|LJ' }
      available_dir = {
        'S': 'NEWS',
        '|': 'NS',
        '-': 'EW',
        'L': 'NE',
        'J': 'NW',
        'F': 'ES',
        '7': 'WS',
      }[current.to_sym]
      available_dir.include?(dir) ? possible_pipes[dir.to_sym] : []
    end

    # const = {r_max, c_max}
    def traverse(r, c, const)
      @@news
        .map{|dr, dc, dir| [r+dr, c+dc, dir]}
        .filter{|new_r,new_c,dir|
          (0...const[:r_max]).include?(new_r) and (0...const[:c_max]).include?(new_c) \
            and !$traversed.member?([new_r, new_c]) \
            and get_possible_pipes(data[r][c], dir).include?(data[new_r][new_c])
        }
        .map{_1.take(2)}
    end

    def get_start
      for row, idx_row in data.each_with_index
        if row.include?('S')
          return [idx_row, row.index('S')]
        end
      end
    end

    def part_1
      $traversed.clear # clear global var before start
      r_max, c_max = data.size, data[0].size
      const = {r_max: r_max, c_max: c_max}

      start = get_start
      $traversed.add(start)

      current_pos = traverse(*start, const)
      current_pos.each{$traversed.add(_1)}
      step = 1
      found = false
      while not found do
        current_pos.map!{|pos|
          res = traverse(*pos, const)
          if res.size == 0
            found = true
            break
          end
          $traversed.add(res[0])
          res[0]
        }
        step += 1
      end
      step
    end

    def is_start_dir_north?(r,c)
      '|7F'.include?(data[r-1][c])
    end

    def part_2
      part_1
      new_data = data
      r_max, c_max = data.size, data[0].size

      north_pipe = 'LJ|'
      if is_start_dir_north?(*get_start)
        north_pipe += 'S'
      end

      res = 0
      for r in 0...r_max
        # out = ''
        for c in 0...c_max
          char = data[r][c]
          if !$traversed.member?([r, c]) # disregard all unconnected pipe
            if (new_data[r][0...c].count north_pipe) % 2 != 0
              new_data[r][c] = '#'
              res += 1
            else
              new_data[r][c] = ' '
            end
          end
          # out += new_data[r][c] == '#' ? Paint[new_data[r][c], :red, :bright] : new_data[r][c]
        end
        # puts out
      end
      res
    end

  end
end
