# Time: 33.26s

@factorisations = {}

def factorisations(num)
  return [[2]] if num == 2
  return @factorisations[num] if @factorisations[num]
  bound = Math.sqrt(num)
  curr_divisor = 1
  array = []
  until curr_divisor > bound
    curr_divisor += 1
    next if not num % curr_divisor == 0
    old_factorisation = factorisations(num / curr_divisor)
    array += old_factorisation.map { |ary| ary + [curr_divisor] }
  end
  array.push([num])
  @factorisations[num] = array
end

def sum_product?(i, k)
  return factorisations(i).any? { |factorisation|
     k - factorisation.size + factorisation.inject(:+) == i
  }
end

def minimum_product_sum(k)
  i = k
  i += 1 until sum_product?(i, k)
  return i
end

ary = []
2.upto(12000) { |i| ary.push(minimum_product_sum(i)) }
p ary.uniq.inject(:+)
