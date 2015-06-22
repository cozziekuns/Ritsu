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
# ** Main
#==============================================================================

iterations = 1
fraction = Fraction.new(1, 1)

while iterations < 99
  if iterations % 3 == 1
    value = 2 * (33 - (iterations + 1) / 3)
  else
    value = 1
  end
  fraction.add(value)
  fraction.invert
  iterations += 1
end

fraction.add(2)

puts fraction.numerator.to_s.split("").map { |s| s.to_i }.inject(:+)