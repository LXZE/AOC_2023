# frozen_string_literal: true
module Year2023
  class Day07 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    @@play_rank = [[5], [4, 1], [3, 2], [3, 1, 1], [2, 2, 1], [2, 1, 1, 1], [1, 1, 1, 1, 1]].reverse!
    @@rank = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'].reverse!
    @@rank_joker = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'].reverse!

    def parse
      data.map{|l| l.split(' ')}.map{|play, point| [play, point.to_i]}
    end

    def get_power(play)
      @@play_rank.index(play.split('').group_by(&:itself).values.map(&:count).sort.reverse)
    end

    def get_power_joker(play)
      play.include?('J') \
        ? @@rank_joker[1..].map{|ch| get_power(play.gsub('J', ch))}.max \
        : get_power(play)
    end

    def compare_card(play1, play2, is_joker = false)
      rank_list = is_joker ? @@rank_joker : @@rank
      play1.split('').zip(play2.split('')).each {|a,b|
        if a != b
          return rank_list.index(a) <=> rank_list.index(b)
        end
      }
    end

    def part_1
      parse.sort{|a, b|
        p1 = get_power(a[0]); p2 = get_power(b[0])
        p1 != p2 ? p1 <=> p2 : compare_card(a[0], b[0])
      }.map(&:last).map.with_index(1){|point, idx| point * idx}.sum
    end

    def part_2
      parse.sort{|a, b|
        p1 = get_power_joker(a[0]); p2 = get_power_joker(b[0])
        p1 != p2 ? p1 <=> p2 : compare_card(a[0], b[0], true)
      }.map(&:last).map.with_index(1){|point, idx| point * idx}.sum
    end

  end
end
