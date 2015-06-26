Matrix = []

File.open("matrix.txt") { |f|
  f.each_line { |line| Matrix.push(line.split(",").map { |s| s.to_i }) }
}

path_sums = Array.new(Matrix.size, 0)
total_top = []
total_bottom = []

Matrix[0].size.times { |curr_x|

  # Check the shortest path coming in from the top
  Matrix.size.times { |curr_y|
    if curr_y == 0
      total_top[curr_y] = path_sums[curr_y]
    else
      total_top[curr_y] = [path_sums[curr_y], total_top[curr_y - 1]].min
    end
    total_top[curr_y] += Matrix[curr_y][curr_x]
  }

  # Check the shortest path coming in from the bottom
  (Matrix.size - 1).downto(0) { |curr_y|
    if curr_y == Matrix.size - 1
      total_bottom[curr_y] = path_sums[curr_y]
    else
      total_bottom[curr_y] = [path_sums[curr_y], total_bottom[curr_y + 1]].min
    end
    total_bottom[curr_y] += Matrix[curr_y][curr_x]
  }

  Matrix.size.times { |curr_y|
    # The new path sums are the minimum of coming from the top and coming
    # from the bottom
    path_sums[curr_y] = [total_top[curr_y], total_bottom[curr_y]].min
  }

}

p path_sums.min
