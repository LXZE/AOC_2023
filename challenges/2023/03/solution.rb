# frozen_string_literal: true
module Year2023
  class Day03 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def is_valid?(idxs)
      for r,c in idxs
        if data[r][c].match?(/[^\.\d]/)
          return [true, data[r][c], [r, c]]
        end
      end
      return [false]
    end

    def get_pos(idx_r, idx_c_st, idx_c_en, rows_amnt, cols_amnt)
      res = []
      if idx_r > 0
        for c in ([idx_c_st-1, 0].max)..([idx_c_en, cols_amnt-1].min)
          res.push([idx_r-1, c])
        end
      end
      if idx_c_st > 0
        res.push([idx_r, idx_c_st-1])
      end
      if idx_c_en < cols_amnt-1
        res.push([idx_r, idx_c_en])
      end

      if idx_r < rows_amnt-1
        for c in ([idx_c_st-1, 0].max)..([idx_c_en, cols_amnt-1].min)
          res.push([idx_r+1, c])
        end
      end

      return res
    end

    def part_1
      sum = 0
      r = data.size
      c = data[0].size
      data.each_with_index {|l, idx_row| l.scan(/\d+/) {
        |match|
          if is_valid?(get_pos(idx_row, *$~.offset(0), r, c))[0]
            sum += match.to_i
          end
      } }
      sum
    end

    def part_2
      found = {}
      r = data.size
      c = data[0].size
      data.each_with_index {|l, idx_row| l.scan(/\d+/) {
        |match|
          res = is_valid?(get_pos(idx_row, *$~.offset(0), r, c))
          if res[0] and res[1] == '*'
              if found[res[2]] == nil
                found[res[2]] = [match.to_i]
              else
                found[res[2]].push(match.to_i)
              end
          end
      } }
      found.values
        .filter {|p| p.size == 2}
        .map {|a,b| a*b }
        .sum
    end
  end
end
