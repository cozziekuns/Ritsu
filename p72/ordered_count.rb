# Time: 96.55s
require "prime"

# Generate a sufficient list of primes
@prime_hash = {}
@primes = Prime.first(100000)
@primes.each { |prime| @prime_hash[prime] = true }

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
  @primes.each { |prime|
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
  return factors
end

answer =  2.upto(1000000).inject(0) { |total, curr| total += totient(curr) }
p answer
