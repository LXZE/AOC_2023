# frozen_string_literal: true
module Year2023
  class Day20 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    class Comps

      # @param name [String]
      # @param type [String]
      # @param targets [Array<String>]
      def initialize(name, type, targets)
        @name = name
        @type = type.nil? ? '' : type
        @targets = targets
        @state = 'lo'
        # for conjunction &
        @watching = {}
      end

      def set_watching(sources)
        @watching = sources.map{[_1, 'lo']}.to_h
      end
      def watching; @watching end
      def targets; @targets end
      def state; @state end
      def toggle_state; @state = (@state == 'lo' ? 'hi' : 'lo') end

      def emit(from, input_pulse)
        case @type
        when '' # boardcaster
          @targets.map{[@name, input_pulse, _1]}
        when '%' # flip-flop
          if input_pulse == 'lo';
            toggle_state
            @targets.map{[@name, @state, _1]}
          else
            []
          end
        when '&' # conjunction
          @watching[from] = input_pulse
          out_pulse = @watching.values.all?('hi') ? 'lo' : 'hi'
          @targets.map{[@name, out_pulse, _1]}
        end
      end
    end

    # @return [Hash<String, Comps>]
    def parse
      init_hash = {'button' => Comps.new('button', nil, ['broadcaster'])}
      mem = {}; conjs = []
      board = data.map{|line|
        src, targets = line.split(' -> ')
        targets = targets.split(', ')
        type, key = src.scan(/(?<type>[%&])?(?<key>\w+)/)[0]
        if type == '&'; conjs.push(key) end
        mem[key] = targets
        [key, type, targets]
      }.reduce(init_hash){|acc, (key, type, targets)|
        acc[key] = Comps.new(key, type, targets)
        acc
      }
      conjs.each{|conj|
        board[conj].set_watching(mem.filter{|k,v| v.include?(conj)}.keys)
      }
      board
    end

    def part_1
      board = parse
      lo_count, hi_count = 0, 0
      1000.times.each{
        queue = board['button'].emit('button', 'lo')
        lo_count += 1
        while queue.size > 0
          from, pulse, to = queue.shift
          if !board.has_key?(to); next end
          res = board[to].emit(from, pulse)
          res.each{
            # p "#{_1[0]} -#{_1[1]}-> #{_1[2]}"
            if _1[1] == 'lo'; lo_count += 1 end
            if _1[1] == 'hi'; hi_count += 1 end
          }
          queue.push(*res.reject{_1[2] == 'output'})
        end
      }
      [lo_count, hi_count].inject(:*)
    end

    def part_2
      board = parse
      count = 0
      found = false

      main_conj = board.filter{|_, c| c.targets.include? 'rx'} # find conj that sends signal to rx
      target = main_conj.keys[0]
      deps = main_conj.values[0].watching.keys.map{[_1, Float::INFINITY]}.to_h

      while deps.values.any?(Float::INFINITY)
        queue = board['button'].emit('button', 'lo')
        count += 1
        while queue.size > 0
          from, pulse, to = queue.shift
          if to == target and pulse == 'hi'
            deps[from] = [deps[from], count].min
          end
          if !board.has_key?(to); next end
          res = board[to].emit(from, pulse)
          queue.push(*res.reject{_1[2] == 'output'})
        end
      end

      deps.values.inject(&:lcm)
    end

  end
end
