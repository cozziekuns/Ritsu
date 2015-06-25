# Time: 23.38s

# Memoize
@memo = {}

# Pentagonal Number Formula
def pent(n)
  return (n * (3 * n - 1)) / 2
end

# Euler's recurrence function
def partition(n)
  return 1 if n == 0
  return @memo[n] if @memo[n]
  answer = 0
  index = 1
  sign = 1
  while true
    pentagonal = pent(index)
    break if n - pentagonal < 0
    answer += sign * partition(n - pentagonal)
    # Change signs after the negative index
    sign = -sign if index < 0
    index = -index
    # Increment after the negative index (new index is positive)
    index += 1 if index > 0
  end
  # cache for later calls to the function
  @memo[n] = answer
  return @memo[n]
end

n = 1
n += 1 until partition(n) % 1000000 == 0
p n
