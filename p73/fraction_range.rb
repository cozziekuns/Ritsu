# Time: 18.97s
total = 0

# Thanks CS70
def gcd(x, y)
  return x if y == 0
  return gcd(y, x % y)
end

def proper?(numerator, denominator)
  gcd(denominator, numerator) == 1
end

count = 0

12000.times { |denom|
  12000.times { |num|
    break if num >= denom
    # Keep it only if in the range between 1 / 3 and 1 / 2
    break if 1.0 * (num + 1) / (denom + 1) >= 0.5
    next if 1.0 * (num + 1) / (denom + 1) <= 1.0 / 3
    # Get rid of it if it's not proper
    next if not proper?(num + 1, denom + 1)
    count += 1
  }
}

p count
