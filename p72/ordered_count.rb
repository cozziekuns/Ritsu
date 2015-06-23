# Time: 9.24s
require "prime"

# Generate a sufficient list of primes
@prime_hash = {}
@primes = Prime.first(100000)
@primes.each { |prime| @prime_hash[prime] = true }

# Memoize prime factors
@factors_hash = {}

# Fast way of calculating totient function
def totient(n)
  return n if n == 1
  return n - 1 if @prime_hash[n]
  factors = prime_factors(n)
  numerator = n * factors.map { |i| i - 1 }.inject(:*)
  denominator = factors.inject(:*)
  return numerator / denominator
end

# "Fast" method of calculating prime factors
def prime_factors(n)
  factors = []
  old_n = n
  @primes.each { |prime|
    if @factors_hash[n]
      factors += @factors_hash[n]
      factors.uniq!
      break
    end
    if n % prime == 0
      factors.push(prime)
      n /= prime
    end
    break if prime >= n
    # If the remainder is a prime, add and break
    if @prime_hash[n]
      factors.push(n)
      break
    end
  }
  @factors_hash[old_n] = factors
  return factors
end

answer =  2.upto(1000000).inject(0) { |total, curr| total += totient(curr) }
