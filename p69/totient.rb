# Generate a sufficient list of primes
require "prime"

primes = Prime.first(100)

# Multiply primes together until the value is as large as possible
value = 1
next_value = primes.shift

until value * next_value > 1000000
  value *= next_value
  next_value = primes.shift
end

p value
