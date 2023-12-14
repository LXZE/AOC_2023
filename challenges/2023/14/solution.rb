# frozen_string_literal: true
module Year2023
  class Day14 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map{_1.split('')}
    end

    def move(map)
      Enumerator.product(1...map.size, 0...map[0].size).each {|r,c|
        if map[r][c] == 'O'
          block = (r-1).downto(0).find{['#', 'O'].include? map[_1][c]}
          map[r][c] = '.'
          map[block.nil? ? 0 : block+1][c] = 'O'
        end
      }
      map
    end

    def calc(map)
      map.map.with_index{_1.count('O') * (map.size - _2)}.sum
    end

    def part_1
      calc(move(parse))
    end

    def cycle(map)
      4.times{map = move(map).transpose.map(&:reverse)}
      map
    end

    def part_2
      map = parse
      step = 0
      register = {}
      start_size = 0
      cycle_size = 0

      loop do
        map = cycle(map)
        step += 1
        key = map.map{_1.join('')}.join('')
        if register.key?(key)
          start_size = register[key]
          cycle_size = step - start_size
          break
          # raise "cycle found! at #{step}, prev = #{register[key]}"
        else
          register[key] = step
        end
      end

      remain_size = (1_000_000_000 - start_size) % cycle_size
      remain_size.times{map = cycle(map)}
      calc(map)
    end
  end
end
