# Time: 0.07s

def square?(n)
  return n / Math.sqrt(n) == Math.sqrt(n).floor
end

def square_root(n, precision)
  result = ""
  root_so_far = 0
  digits = 0
  string = n.to_s
  # Hack to account for numbers with an odd number of digits
  string = "0" + string if string.size % 2 == 1
  remainder = 0
  decimal_placed = false
  until digits >= precision
    # Calculate the new remainder
    remainder *= 100
    if string.size >= 2
      remainder += string[0...2].to_i
      string = string[2..-1]
    end
    break if remainder == 0
    # Let y = x(20p + x), where x is the value that brings x(20p + x) closest
    # to the current remainder
    x = 0
    y = 0
    x += 1 until (x + 1) * (20 * root_so_far + (x + 1)) > remainder
    y = x * (20 * root_so_far + x)
    # New remainder is remainder - y
    remainder = remainder - y
    result += x.to_s
    if not decimal_placed and string.empty?
      result += "."
      decimal_placed = true
    end
    root_so_far = root_so_far * 10 + x
    digits += 1
  end
  return result
end

def digital_root(n)
  n.sub(".", "").split("").map { |s| s.to_i }.inject(:+)
end

total = 0

1.upto(100) { |i|
  next if square?(i)
  total += digital_root(square_root(i, 100))
}

p total
