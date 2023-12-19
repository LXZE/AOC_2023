# frozen_string_literal: true
module Year2023
  class Day19 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      flows, parts = data.reduce([[]]){|acc,e| e == '' ? acc.push([]) : acc[-1].push(e); acc}
      parts.map!{|part| part[1...-1].split(',').map{_1.split('=')[1].to_i}}
      [flows, parts]
    end

    @@parts = %w[x m a s]
    def gen_proc(cmdstr)
      cmdstr.split(',').map{|cmd|
        if !cmd.include?(':')
          -> _pl { cmd }
        else
          key, ops, val, target = cmd.scan(/(?<key>\w+)(?<ops>[\<\>])(?<val>\d+):(?<tgt>\w+)/)[0]
          fn = -> a, b { ops == '<' ? a < b : a > b }
          -> pl { fn[pl[@@parts.index(key)], val.to_i] ? target : nil }
        end
      }
    end

    def part_1
      flows, parts = parse
      flows = flows.reduce({}){|acc,flow|
        key, remain = flow[...-1].split(/\{/)
        acc[key] = gen_proc(remain)
        acc
      }
      terminals = ['A', 'R']
      parts.reduce(0){|acc, part|
        current_flow = 'in'
        while not terminals.include?(current_flow)
          flows[current_flow].each{|f|
            res = f[part]
            if res.nil?; next end
            current_flow = res
            break
          }
        end
        if current_flow == 'A'; acc += part.sum end
        acc
      }
    end

    def gen_range_split(cmdstr)
      -> parts {
        # [new_splited_parts: [(target: str, part: [int])], remain_parts for split: [int]]
        cmdstr.split(',').reduce([[], parts]){|acc, cmd|
          if acc[1].size == 0; return acc end
          acc, remain_parts = acc
          if !cmd.include?(':')
            acc.push([cmd, remain_parts])
            [acc, []]
          else
            key, ops, val, target = cmd.scan(/(?<key>\w+)(?<ops>[\<\>])(?<val>\d+):(?<tgt>\w+)/)[0]
            key = @@parts.index(key)
            val = val.to_i
            new_acc = []
            part_l, part_r = Array.new(2){remain_parts.clone}
            if ops == '<'
              if part_l[key].end < val # range in key all less than split val
                part_r = []
                acc.push([target, part_l])
              elsif part_l[key].include?(val) # split position in range
                part_l[key] = part_l[key].begin..(val-1)
                part_r[key] = val..(part_r[key].end)
                acc.push([target, part_l])
              end # else, do nothing
              new_acc = [acc, part_r]
            else
              if val < part_r[key].begin # range in key all more than split val
                part_l = []
                acc.push([target, part_r])
              elsif part_r[key].include?(val) # split position in range
                part_l[key] = part_l[key].begin..val
                part_r[key] = (val+1)..(part_r[key].end)
                acc.push([target, part_r])
              end # else, do nothing
              new_acc = [acc, part_l]
            end
            new_acc
          end
        }[0]
      }
    end

    def part_2
      flows, _ = parse
      flows = flows.reduce({}){|acc,flow|
        key, remain = flow[...-1].split(/\{/)
        acc[key] = gen_range_split(remain)
        acc
      }
      states = [['in', Array.new(4){1..4000}]]
      res = 0
      while states.size > 0
        key, part = states.shift
        new_parts = flows[key][part]
        new_parts.each{|key, new_part|
          if key == 'A'; res += new_part.map(&:size).inject(:*)
          elsif key == 'R'; next
          else; states.push([key, new_part])
          end
        }
      end
      res
    end

  end
end
