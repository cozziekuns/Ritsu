# Time: 0.86s

def valid?(array)
  check_sum = array[4] + array[5] + array[9]
  4.times { |i|
    sum = array[i] + array[i + 5] + array[i + 6]
    return false if sum != check_sum
  }
  return true
end

def transform(permutation)
  result = []
  curr_index = permutation.index(permutation[0...5].min)
  5.times {
    if curr_index == 4
      result += [permutation[4], permutation[9], permutation[5]]
    else
      result.push(permutation[curr_index])
      result.push(permutation[curr_index + 5])
      result.push(permutation[curr_index + 6])
    end
    curr_index = (curr_index + 1) % 5
  }
  return result.map { |i| i.to_s }.join.to_i
end

largest_permutation = 0

1.upto(9).to_a.permutation.each { |permutation|
  permutation.unshift(10)
  if valid?(permutation)
    new_permutation = transform(permutation)
    if new_permutation > largest_permutation
      largest_permutation = new_permutation
    end
  end
}

p largest_permutation
