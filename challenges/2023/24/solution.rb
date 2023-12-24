# frozen_string_literal: true
module Year2023
  class Day24 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    @@is_test = ENV['RB_ENV'] == 'test'
    @@range = @@is_test ? 7..27 : 200000000000000..400000000000000

    class Vector
      attr_accessor *%i[x y z vx vy vz]
      def initialize(*args)
        @x, @y, @z, @vx, @vy, @vz = args
      end
    end

    def parse
      data.map{Vector.new *_1.scan(/-?\d+/).map(&:to_i)}
    end

    # @param a [Vector]
    # @param b [Vector]
    def intersect?(a, b)
      denom = (a.vx * b.vy) - (a.vy * b.vx)
      return false if denom == 0
      delta = ((b.vy * (b.x + b.vx - a.x)) + (-b.vx * (b.y + b.vy - a.y))) / denom.to_f
      x = a.x + (delta * a.vx)
      y = a.y + (delta * a.vy)
      return false if ( # intersect in the past
        (x < a.x && a.vx > 0) || (x > a.x && a.vx < 0) or
        (x < b.x && b.vx > 0) || (x > b.x && b.vx < 0)
      )
      [x, y].all?{@@range.include? _1}
    end

    def part_1
      parse.combination(2).count{intersect? *_1}
    end

    require 'z3'
    include Z3

    def part_2
      hails = parse
      solver = Solver.new
      x, y, z, vx, vy, vz = %w[x y z vx vy vz].map{Int _1}
      for hail, idx in hails.each_with_index
        t = Int "t#{idx}"
        solver.assert t>0
        solver.assert x + (vx * t) == hail.x + (hail.vx * t)
        solver.assert y + (vy * t) == hail.y + (hail.vy * t)
        solver.assert z + (vz * t) == hail.z + (hail.vz * t)
      end
      if solver.satisfiable?
        result = solver.model.to_h
        [x,y,z].sum{result[_1].to_i}
      else
        raise 'No answer'
      end
    end

  end
end
