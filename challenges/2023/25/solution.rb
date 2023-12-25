# frozen_string_literal: true
module Year2023
  class Day25 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def parse
      data.map{_1.scan /\w+/}
        .reduce(Hash.new{|h,k| h[k] = Set[]}){|g, (from, *tos)|
          tos.reduce(g){|acc, to|
            acc[from] << to; acc[to] << from; acc
          }
        }
    end

    class Groups
      attr_reader :count
      def initialize nodes
        @parent = nodes.map{[_1, _1]}.to_h
        @rank = nodes.map{[_1, 0]}.to_h
        @count = nodes.size
      end
      def find node
        if @parent[node] != node
          @parent[node] = find(@parent[node])
        end
        @parent[node]
      end
      def contract node1, node2
        # find group root of each node
        g1, g2 = [node1, node2].map{find _1}.sort_by {-@rank[_1]}
        # if rank equal, add one to larger group
        if g1 != g2 and @rank[g1] == @rank[g2]
          @rank[g1] += 1
        end
        # assign group root to larger group
        @parent[g2] = g1
        # decrease amount if different group merged
        @count -= g1 != g2 ? 1 : 0
      end
      def groups
        @parent.keys.reduce(Hash.new {|h,k| h[k] = Set[]}){|acc, node|
          acc[find(node)] << node; acc
        }.values
      end
    end

    def part_1
      graph = parse
      pairs = graph.flat_map{|k, vs| vs.map{|v| [k, v]}}
      res = 0
      while res == 0
        g = Groups.new graph.keys
        # randomly contract edge until only 2 nodes left in graph
        pairs.shuffle.each {|a,b|
          if g.find(a) != g.find(b)
            g.contract(a, b)
            break if g.count == 2 # contracted only 2 nodes left
          end
        }
        a, b = g.groups
        cuts = pairs.count{a.include? _1 and b.include? _2}
        if cuts==3
          res = a.size * b.size
        end
      end
      res
    end

    def part_2
      puts "Merry X'mas :D"
      nil
    end
  end
end
