# Time: 2.18s

def rectangle_number(width, height)
  count = 0
  width.times { |i|
    height.times { |j|
      count += (width - i) * (height - j)
    }
  }
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
