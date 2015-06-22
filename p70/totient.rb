# Generate a sufficient list of primes

primes = [2]
i = 3

(3..100000).step(2) { |i|
  is_prime = true
  primes.each { |prime| 
    break if not is_prime
    break if Math.sqrt(i) < prime
    is_prime = false if i % prime == 0
  }
  primes.push(i) if is_prime
}

best_ratio = 5
best_value = 0

primes.each { |check_prime|
  primes.each { |prime|
    i = check_prime * prime
    break if i > 10000000
    next if prime < check_prime
    # Pattern seems to be:
    # totient(prime_a * prime_b) = (prime_a - 1) * prime_b - (prime_a - 1)
    totient = (check_prime - 1) * prime - (check_prime - 1)
    # Simple permutation check
    if totient.to_s.split("").sort == i.to_s.split("").sort
      new_ratio = 1.0 * i / totient
      if new_ratio < best_ratio
        best_ratio = new_ratio
        best_value = i
      end
    end
  }
}

p best_value