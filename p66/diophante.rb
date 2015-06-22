#==============================================================================
# ** Fraction
#==============================================================================

class Fraction
  
  attr_reader   :numerator
  attr_reader   :denominator
  
  def initialize(numerator, denominator)
    @numerator = numerator
    @denominator = denominator
  end
  
  def add(integer)
    @numerator += integer * @denominator
  end
  
  def invert
    temp = @denominator
    @denominator = @numerator
    @numerator = temp
  end
  
end

#==============================================================================
# ** Diophante
#==============================================================================

best_d = 0
max_solution = 0
t = Time.now

1000.times { |d|
  next if d == 0
  next if d / Math.sqrt(d) == Math.sqrt(d).floor
  nearest_square = Math.sqrt(d).floor * Math.sqrt(d).floor
  base = Math.sqrt(nearest_square).floor
  top = 0
  bottom = 1
  continued_fraction = [base]
  loop {
    step2 = [bottom, (top - bottom * base).abs]
    top, bottom = [step2[1], (d - step2[1] * step2[1])/ step2[0]]
    base = ((Math.sqrt(d) + top) / bottom).floor
    continued_fraction.push(base)
    break if bottom == 1
  }
  if continued_fraction.size % 2 == 0
    period = continued_fraction[1..-1]
    continued_fraction += period
  end
  continued_fraction.pop
  fraction = Fraction.new(0, 1)
  continued_fraction.size.times { |i|
    index = continued_fraction.size - i - 1
    fraction.add(continued_fraction[index])
    fraction.invert if index > 0
  }
  if fraction.numerator > max_solution
    best_d = d
    max_solution = fraction.numerator
  end
}
p Time.now - t
p best_d