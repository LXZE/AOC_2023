# LXZE's 2023 Advent of Code solutions

[siteURL]: https://adventofcode.com/2023
[baseURL]: /challenges/2023

This repository is an archive of my solutions in [Advent of Code 2023][siteURL].  
Each day's solution are in folder [challenges/2023][baseURL]

Read it at your own risk.  

## Prerequisite
- ruby ~> 3.2.0 
- z3 ~> 4.8


## Used lib
- aoc_rb
- algorithms
- paint
- matrix
- z3

## Commands
```bash
# Install aoc_rb
gem install aoc_rb

# Install all required libs
bundle install

# Download input file for each day
aoc prep 2023 <$day>

# Run on test
aoc spec 2023 <$day>

# Run on actual output
aoc output 2023 <$day>

```

## Note 
### Keyword for googling 
- Day 10: Even-odd rule
- Day 18: Shoelace formula + Pick's formula
- Day 23: Longest Path Problem
- Day 24: Vector intersection
- Day 25: Minimum cut, Karger's algorithm

### Problem explanation
- [Day 17](/challenges/2023/17/solution.rb)
	- Problem
		- Find the shortest path with specific amount of traversable tiles in same direction
	- Solution
		- Add all traversable tiles after turn to minheap and perform dijkstra.

- [Day 18](/challenges/2023/18/solution.rb)
	- Problem
		- Find internal points inside the irregular polygon
	- Solution
		- Using Shoelace formula to calculate internal Area  
				$$
				Area = \frac{1}{2} \sum_{i=1}^n det \begin{pmatrix} x_i & x_{i+1} \\
				y_i & y_{i+1}
				\end{pmatrix}
				$$  
		- Using with Pick's formula to calculate internal points inside the irregular polygon  
			ps. (A = Area from shoelace formula, P = Perimeter, I = Internal points amount)  
				$$ A = \frac{1}{2}P + I - 1 $$
			Then
				$$ I = A - \frac{1}{2}P + 1 $$
			Answer includes perimeter, so add P to the equation  
				$$ I = A + \frac{1}{2}P + 1 $$

- [Day 21](/challenges/2023/21/solution.rb)
	- Problem
		- Find the tile to step on after N steps in the infinite map
	- Solution  
		- As the actual input could result in diamond shape (empty start row and column), we can simulate outward from 1x1 map to just 5x5 map, then calculate the tiles in each type of map accordingly.
		```txt
		..#..
		.#.#.
		#.#.#
		.#.#.
		..#..
		```
		```ruby
		num = steps / map.size
		tips = [[0, 2], [2, 0], [2, 4], [4, 2]].sum{counter.dig(_1)}
		edge_outer = [[0, 1], [1, 4], [3, 0], [4, 3]].sum{counter.dig(_1)}
		edge_inner = [[1, 1], [1, 3], [3, 1], [3, 3]].sum{counter.dig(_1)}
		center = counter.dig([2, 2])
		notcenter = counter.dig([2, 3])
		result = tips \
		+ (edge_outer * num) \
		+ (edge_inner * (num-1)) \
		+ (notcenter  * (num ** 2)) \
		+ (center     * ((num-1) ** 2))
		```

- [Day 23](/challenges/2023/23/solution.rb)
	- Problem
		- Find the longest path in the graph
	- Solution  
		- Brute force by bfs then accumulate distance for each path and find max

- [Day 24](/challenges/2023/24/solution.rb)
	- Problem
		1. Find the points that 2D vectors intersect
		2. Find the 3D vector that collide with every other vectors
	- Solution  
		- Part 1
		1. Find vector denominator first then find delta
			```ruby
			denom = (a.vx * b.vy) - (a.vy * b.vx)
			return nil if denom == 0 # 2 vectors are parallel
			delta = ((b.vy * (b.x + b.vx - a.x)) + (-b.vx * (b.y + b.vy - a.y))) / denom.to_f
			x = a.x + (delta * a.vx)
			y = a.y + (delta * a.vy)
			```
			x, y would be the position that 2 vectors intersect
		2. 
		- Part 2
			- using Z3 solver XD
		

- [Day 25](/challenges/2023/25/solution.rb)
	- Problem
		- Find 3 edges that remove from the graph would result in 2 separated graphs
	- Solution
		- Using Karger's algorithm
			1. Randomly contracted node and one of its neighbors until 2 nodes remained
			2. Count edges that each vertex belongs to each nodes' group respectively
