# Time: 16.8s

def factorial(n)
  return 1 if n == 0
  return 1.upto(n).inject(:*)
end

def factorial_sum(n)
  n.to_s.split("").map { |s| factorial(s.to_i) }.inject(:+)
end

cache = {}
1.upto(1000000).each { |i|
  seen = {}
  count = 0
  until seen[i]
    # If the value is cached, that means we already know how many terms
    # before there is a cycle, so just add that value to the current
    # count.
    if cache[i]
      count += cache[i]
      break
    else
      # Otherwise, just loop through until we reach a cycle
      seen[i] = count
      i = factorial_sum(i)
      count += 1
    end
  end
  # Total counts - count value when first seen = actual count value
  seen.keys.each { |key| cache[key] = count - seen[key] }
}

# Only count values that have 60 terms in its chain
answer = cache.keys.select { |key| cache[key] == 60 }.size
p answer
