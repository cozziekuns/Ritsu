@memo = {}

# CS61A
def sum_partition(n, m)
  return @memo[[n, m]] if @memo[[n, m]]
  if n == 0
    return 1
  elsif n < 0
    return 0
  elsif m == 0
    return 0
  else
    answer = sum_partition(n - m, m) + sum_partition(n, m - 1)
    @memo[[n, m]] = answer
    return answer
  end
end

p sum_partition(100, 99)
