# Generate a sufficient list of primes

primes = [2]
i = 3

(3..100).step(2) { |i|
  is_prime = true
  primes.each { |prime| 
    break if not is_prime
    break if Math.sqrt(i) < prime
    is_prime = false if i % prime == 0
  }
  primes.push(i) if is_prime
}

# Multiply primes together until the value is as large as possible

value = 1
next_value = primes.shift

until value * next_value > 1000000
  value *= next_value
  next_value = primes.shift
end

p value