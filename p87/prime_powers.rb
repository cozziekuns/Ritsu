# Time: 1.97s

require "prime"

limit = 50000000
list = []

primes = Prime.first(50000)
primes_squared = primes.map { |prime| prime * prime }
primes_cubed = primes.map { |prime| prime ** 3 }
primes_fourth = primes.map { |prime| prime ** 4 }

primes_fourth.each { |fourth|
  break if fourth > limit
  primes_cubed.each { |cube|
    break if fourth + cube > limit
    primes_squared.each { |square|
      result = fourth + cube + square
      break if result > limit
      list.push(result)
    }
  }
}

p list.uniq.size
