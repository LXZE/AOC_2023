# frozen_string_literal: true
module Year2023
  class Day11 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    # def expand
    #   expand_reduce_fn = -> acc, elem {
    #     elem.all?('.') ? acc.push(elem, elem) : acc.push(elem)
    #   }
    #   data.map{_1.split('')}
    #     .reduce([], &expand_reduce_fn).transpose
    #     .reduce([], &expand_reduce_fn).transpose
    # end

    # def distance(p1, p2)
    #   (p2[0] - p1[0]).abs + (p2[1] - p1[1]).abs
    # end

    def distance(p1, p2, empty_row_list, empty_col_list, part2 = false)
      empty_row = empty_row_list.count{(p1[0]...p2[0]).include?(_1)}
      filled_row = ((p1[0]...p2[0]).size - empty_row).abs

      plc, phc = [p1[1],p2[1]].minmax
      empty_col = empty_col_list.count{(plc...phc).include?(_1)}
      filled_col = ((plc...phc).size - empty_col).abs

      multiplier = part2 ? 1_000_000 : 2 # 100 for testing
      (empty_row*multiplier + filled_row) + (empty_col*multiplier + filled_col)
    end

    def solve(part2 = false)
      empty_row_idx, empty_col_idx = [], []
      map = data.map{_1.split('')}
      map
        .each_with_index{if _1.all?('.') then empty_row_idx.push(_2) end}.transpose
        .each_with_index{if _1.all?('.') then empty_col_idx.push(_2) end}.transpose

      stars_pos = []
      map.each_with_index{|l, idx_r|
        l.each_index.filter{l[_1] == '#'}.each{stars_pos.push([idx_r, _1])}
      }
      stars_pos.combination(2).map{distance(*_1, empty_row_idx, empty_col_idx, part2)}.sum
    end

    def part_1
      solve
      # stars_pos = []
      # expand.each_with_index{|l, idx_r|
      #   l.each_index.filter{l[_1] == '#'}.each{stars_pos.push([idx_r, _1])}
      # }
      # stars_pos.combination(2).map{distance(*_1)}.sum
    end

    def part_2
      solve(true)
    end

  end
end
