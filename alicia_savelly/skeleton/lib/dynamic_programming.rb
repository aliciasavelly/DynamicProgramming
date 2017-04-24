# Dynamic Programming practice
# NB: you can, if you want, define helper functions to create the necessary caches as instance variables in the constructor.
# You may find it helpful to delegate the dynamic programming work itself to a helper method so that you can
# then clean out the caches you use.  You can also change the inputs to include a cache that you pass from call to call.

require 'byebug'

class DPProblems
  def initialize
    # Use this to create any instance variables you may need
    @fibonacci_cache = { 1 => 1, 2 => 1 }
    @str_distance_cache = Hash.new { |hash, key| hash[key] = {} }
  end

  # Takes in a positive integer n and returns the nth Fibonacci
  # number
  # Should run in O(n) time
  def fibonacci(n)
    return @fibonacci_cache[n] if @fibonacci_cache[n]
    result = fibonacci(n - 1) + fibonacci(n - 2)
    @fibonacci_cache[n] = result
    result
  end

  # Make Change: write a function that takes in an amount and a
  # set of coins.  Return the minimum number of coins
  # needed to make change for the given amount.  You may assume
  # you have an unlimited supply of each type of coin.
  # If it's not possible to make change for a given amount, return
  # nil.  You may assume that the coin array is sorted
  # and in ascending order.
  def make_change(amt, coins, coin_cache = {0 => 0})
    return coin_cache[amt] if coin_cache[amt]
    return 0.0 / 0.0 if amt < coins[0]

    min_so_far = amt
    valid = false
    idx = 0
    while idx < coins.length && coins[idx] <= amt
      num_change = 1 + make_change(amt - coins[idx], coins, coin_cache)
      if num_change.is_a?(Integer)
        valid = true
        min_so_far = num_change if num_change < min_so_far
      end

      idx += 1
    end

    if valid
      coin_cache[amt] = min_so_far
    else
      coin_cache[amt] = 0.0 / 0.0
    end

    coin_cache[amt]
  end

  # Knapsack Problem: write a function that takes in an array of
  # weights, an array of values, and a weight capacity
  # and returns the maximum value possible given the weight
  # constraint.  For example: if weights = [1, 2, 3],
  # values = [10, 4, 8], and capacity = 3, your function should
  # return 10 + 4 = 14, as the best possible set of items
  # to include are items 0 and 1, whose values are 10 and 4
  # respectively.  Duplicates are not allowed -- that is, you
  # can only include a particular item once.
  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    solutions = knapsack_table(weights, values, capacity)
    solutions[capacity][weights.length - 1]
  end

  def knapsack_table(weights, values, capacity)
    solutions = []
    (0..capacity).each do |c|
      solutions[c] = []
      (0..weights.length - 1).each do |w|
        if c == 0
          solutions[c][w] = 0
        elsif w == 0
          solutions[c][w] = (weights[0] > c ? 0 : values[0])
        else
          option1 = solutions[c][w - 1]
          option2 = c < weights[w] ? 0 : solutions[c - weights[w]][w - 1] + values[w]
          best = [option1, option2].max
          solutions[c][w] = best
        end
      end
    end

    solutions
  end

  # Stair Climber: a frog climbs a set of stairs.  It can jump
  # 1 step, 2 steps, or 3 steps at a time.
  # Write a function that returns all the possible ways the frog
  # can get from the bottom step to step n.
  # For example, with 3 steps, your function should return
  # [[1, 1, 1], [1, 2], [2, 1], [3]].
  # NB: this is similar to, but not the same as, make_change.
  # Try implementing this using the opposite
  # DP technique that you used in make_change -- bottom up if
  # you used top down and vice versa.
  def stair_climb(n)
    possible_ways = [[[]], [[1]], [[1, 1], [2]]]
    return possible_ways[n] if n < 3

    (3..n).each do |i|
      ways = []
      (1..3).each do |step1|
        possible_ways[i - step1].each do |way|
          new_way = [step1]
          way.each do |step|
            new_way << step
          end

          ways << new_way
        end
      end
      possible_ways << ways
    end

    possible_ways.last
  end

  # String Distance: given two strings, str1 and str2,
  # calculate the minimum number of operations to change str1 into
  # str2.  Allowed operations are deleting a character
  # ("abc" -> "ac", e.g.), inserting a character ("abc" -> "abac", e.g.),
  # and changing a single character into another
  # ("abc" -> "abz", e.g.).

  def str_distance(str1, str2)
    return @str_distance_cache[str1][str2] if @str_distance_cache[str1][str2]

    if str1 == str2
      @str_distance_cache[str1][str2] = 0
      return 0
    end

    if str1.nil?
      return str2.length
    elsif str2.nil?
      return str1.length
    end

    len1 = str1.length
    len2 = str2.length
    if str1[0] == str2[0]
      distance = str_distance(str1[1..len1], str2[1..len2])
      @str_distance_cache[str1][str2] = distance
      # return distance
    else
      possible1 = 1 + str_distance(str1[1..len1], str2[1..len2])
      possible2 = 1 + str_distance(str1, str2[1..len2])
      possible3 = 1 + str_distance(str1[1..len1], str2)
      distance = [possible1, possible2, possible3].min
      @str_distance_cache[str1][str2] = distance
    end

    distance
  end

  # Maze Traversal: write a function that takes in a maze (represented as a 2D matrix) and a starting
  # position (represented as a 2-dimensional array) and returns the minimum number of steps needed to reach the edge of the maze (including the start).
  # Empty spots in the maze are represented with ' ', walls with 'x'. For example, if the maze input is:
  #            [['x', 'x', 'x', 'x'],
  #             ['x', ' ', ' ', 'x'],
  #             ['x', 'x', ' ', 'x']]
  # and the start is [1, 1], then the shortest escape route is [[1, 1], [1, 2], [2, 2]] and thus your function should return 3.
  def maze_escape(maze, start)
  end
end
