class DP
  def initialize
    @cache = { 1 => 1, 2 => 1 }
  end

  def good_fib(n)
    return @cache[n] if @cache[n]
    result = good_fib(n - 1) + good_fib(n - 2)
    @cache[n] = result
    result
  end

  def bad_fib(n)
    return 1 if n == 1 || n == 2
    return bad_fib(n - 1) + bad_fib(n - 2)
  end
end

# memoization
# dp = DP.new()
# p dp.bad_fib(10)
# p dp.bad_fib(25)
# p dp.good_fib(1000)

# vacuous case
# def make_change(amt, coins)
#   # base case:
#     # return infinity if amt < 0
#     # return 0 if amt = 0
#   # recursive case:
#     # loop through coins
#     # temp -> make change called on (amt - coin, coins)
#     # keep track of min_so_far
#     # if temp < min_so_far
#       # swap
#     # return min_so_far + 1
# end

def rec_make_change(amt, coins)
  return 1.0 / 0.0 if amt < 0
  return 0 if amt == 0
  min_so_far = 1.0 / 0.0
  coins.each do |coin|
    temp = rec_make_change(amt - coin, coins) + 1
    if temp < min_so_far
      min_so_far = temp
    end
  end

  min_so_far
end

$cache = { 0 => 0 }
def make_change(amt, coins)
  return 1.0 / 0.0 if amt < 0
  return $cache[amt] if $cache[amt]
  min_so_far = 1.0 / 0.0
  coins.each do |coin|
    temp = make_change(amt - coin, coins) + 1
    if temp < min_so_far
      min_so_far = temp
    end
  end

  $cache[amt] = min_so_far
  min_so_far
end

# p make_change(25, [1, 5, 10, 25])
# p make_change(26, [1, 5, 10, 25])
# p make_change(27, [1, 5, 10, 25])
# p make_change(28, [1, 5, 10, 25])
# p make_change(29, [1, 5, 10, 25])
# p make_change(30, [1, 5, 10, 25])

# knapsack problem
# make a helper:
  # helper[i, w] = highest possible value using only first i
                 # items, using capacity w as restriction
# base case:
  # helper[0, w] = 0
  # helper[i, 0] = 0
  # helper[i, w] = negative infinity if w < 0 or i < 0

# recursive case:
  # indexing from 1
  # helper[i, w] = helper[i - 1, w - wi] + vi
                          # OR
                 # helper[i - 1, w]
                # take the maximum of these two
