# Time: 7.97s
limit = 1500000

triples = []
single_triples = {}

# Build all possible triples using Euclid's formula
2.upto(1200) { |m|
  1.upto(1200) { |n|
    # Make sure m is greater than n
    break if m <= n
    # Check odd difference
    next if not (m - n).odd?
    # Check coprime
    next if not m.gcd(n) == 1
    # Euclid's Method
    a = m * m - n * n
    b = 2 * m * n
    c = m * m + n * n
    triple = [0, 0, 0]
    # Calculate all possible multiples of the triangle until the perimeter
    # is greater than the limit
    while true
      triple[0] += a
      triple[1] += b
      triple[2] += c
      break if triple.inject(:+) >= limit
      triples.push(triple.clone)
    end
  }
}

# uniq is the big thing here. Sometimes, the same triple occurs from
# different primitives!!!
triples.uniq.map { |triple| triple.inject(:+) }.each { |i|
  single_triples[i] ||= 0
  single_triples[i] += 1
}

# Only select singular integer triangles
p single_triples.keys.select { |key| single_triples[key] == 1 }.size
