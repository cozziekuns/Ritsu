# Time: 2.18s

def rectangle_number(width, height)
  count = 0
  # For example, width: 3, height: 2
  # 1x1: (3 - 1 + 1) * (2 - 1 + 1) = 6
  # 2x1: (3 - 2 + 1) * (2 - 1 + 1) = 4
  # 3x1: (3 - 3 + 1) * (2 - 1 + 1) = 2
  # 1x2: (3 - 1 + 1) * (2 - 2 + 1) = 3
  # 2x2: (3 - 2 + 1) * (2 - 2 + 1) = 2
  # 3x2: (3 - 3 + 1) * (2 - 2 + 1) = 1
  # Sum of all of those is 18, which is the correct answer
  width.times { |i| height.times { |j| count += (width - i) * (height - j) } }
  return count
end

closest = 0
area = 0
limit = 2000000

20.upto(100) { |width|
  20.upto(100) { |height|
    rect = rectangle_number(width, height)
    if (limit - rect).abs < (limit - closest).abs
      closest = rect
      area = width * height
    end
  }
}

p area
