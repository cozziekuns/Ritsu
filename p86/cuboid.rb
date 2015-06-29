# Time: 1.46s

# Generate square hash for checking if a value is a square
squares = {}
1.upto(10000) { |i| squares[i * i] = 1 }

total_cuboids = 0
1.upto(10000) { |x|
  # Find the number of integer cuboids with long side length x
  integer_cuboids = 0
  # x * x + (y + z) * (y + z), so y + z cap is 2M
  (2 * x).downto(1) { |y|
    # y here is actually (y + z)
    if squares[x * x + y * y]
      # y - 1 to get rid of the 0 side length z
      [y - 1, x].min.downto(1) { |z|
        break if y - z > z
        integer_cuboids += 1
      }
    end
  }
  total_cuboids += integer_cuboids
  if total_cuboids > 1000000
    p x
    break
  end
}
