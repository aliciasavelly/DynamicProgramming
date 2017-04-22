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

dp = DP.new()
p dp.good_fib(1000)
