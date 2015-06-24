require "prime"

@memo = {}
@primes = Prime.first(10000)

# CS61A modified
def prime_partition(n, prime_index)
  return @memo[[n, prime_index]] if @memo[[n, prime_index]]
  if n == 0
    return 1
  elsif n < 0
    return 0
  elsif prime_index == -1
    return 0
  else
    answer = prime_partition(n - @primes[prime_index], prime_index) +
        prime_partition(n, prime_index - 1)
    @memo[[n, prime_index]] = answer
    return answer
  end
end

i = 4
while true
  # Find the index of the largest prime that is still smaller than the
  # initial value
  prime_index = @primes.index(@primes.find { |prime| prime > i }) - 1
  break if prime_partition(i, prime_index) > 5000
  i += 1
end

p i
