# Time: 0.27s

answer = 0
min_diff = 1

999999.times { |i|
  next if (i + 1) % 7 == 0
  numerator = ((i + 1) * 3 / 7).to_i
  diff = (1.0 * 3 / 7) - (1.0 * numerator / (i + 1))
  if diff < min_diff
    min_diff = diff
    answer = numerator
  end
}

p answer
