# frozen_string_literal: true
module Year2023
  class Day05 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      seeds, *maps = @input.split(/\n\n/)
      seeds = seeds.split(': ')[1].split(' ').map(&:to_i)
      # p seeds
      maps = maps.map {
        |map| map.split(/\n/)[1..]
          .map {|range| range.split(' ').map(&:to_i)}
          .map {|dest, src, size| {range: src..(src+size-1), diff: dest - src }}
      }
      [seeds, maps]
    end

    def part_1
      seeds, maps_list = parse()
      maps_list.reduce(seeds) {
        |acc, maps|
          diffs = acc.map {|seed|
            maps.filter {|map| map[:range].include? seed}.dig(0, :diff)
          }
           acc.zip(diffs).map {|seed, diff| diff.nil? ? seed : seed + diff}
        }.min
    end

    def create_new_range(range, coverage, diff)
      # case 1 cover all range
      if coverage.cover?(range) # cover all
        return {res: [(range.begin)..(range.end), diff], remain: []}
      elsif coverage.cover?(range.begin) and !coverage.cover?(range.end) # cover frontal
        return {res: [(range.begin)..(coverage.end), diff], remain: [
          [(coverage.end+1)..range.end, 0]
        ]}
      elsif !coverage.cover?(range.begin) and coverage.cover?(range.end)  # cover tail
        return {res: [(coverage.begin)..(range.end), diff], remain: [
          [range.begin..(coverage.begin-1), 0]
        ]}
      elsif range.cover?(coverage) # cover subsection
        return {res: [coverage.begin..coverage.end, diff], remain: [
          [range.begin..(coverage.begin-1), 0],
          [(coverage.end+1)..range.end, 0],
        ]}
      else # no overlap
        return {res: [range, 0], remain: []}
      end
    end

    def part_2
      seeds, maps_list = parse()
      seeds_range = seeds.each_slice(2).map {|seed, size| (seed..seed+size-1)}

      maps_list.reduce(seeds_range) {
        |acc_seeds, maps|
          # iterate through all maps then apply diff
          maps.reduce(acc_seeds.map {|s| [s, 0]}) { |acc_range_list, map|
            grouped =  acc_range_list.group_by {|r| r[1] == 0}
            queue = grouped[true]
            res = grouped[false] || []
            while queue.size > 0
              range = queue.shift
              new_range = create_new_range(range[0], map[:range], map[:diff])
              res.push(new_range[:res])
              queue.push(*new_range[:remain])
            end
            res
          }.map {|r, d| r.begin+d..r.end+d}
        }.map(&:begin).min
    end

  end
end
