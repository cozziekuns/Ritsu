# Time: 7.64s
dice = 4

# Start at GO
curr_square = 0
distribution = {}
0.upto(39) { |i| distribution[i] = 0 }

# Create card piles
chance = 0.upto(15).to_a.shuffle
community_chest = 0.upto(15).to_a.shuffle

# Count doubles
doubles = 0

# Simulate 10000 Rolls
10000000.times {
  roll_1 = rand(dice) + 1
  roll_2 = rand(dice) + 1
  # Increment counter if double, otherwise reset
  doubles = (roll_1 == roll_2) ? doubles + 1 : 0
  curr_square = (curr_square + roll_1 + roll_2) % 40
  # 3x Doubles
  if doubles == 3
    doubles = 0
    curr_square = 10
  # Chance
  elsif [7, 22, 36].include?(curr_square)
    curr_square = case chance[0]
    when 0 then 0
    when 1 then 10
    when 2 then 11
    when 3 then 24
    when 4 then 39
    when 5 then 5
    when 6, 7 then
      # Go the nearest railroad (2 / 16)
      if curr_square == 7
        15
      elsif curr_square == 22
        25
      else
        5
      end
    when 8 then (curr_square == 22 ? 28 : 12)
    when 9 then curr_square - 3
    else curr_square
    end
    chance.push(chance.shift)
  # Community Chest
  elsif [2, 17, 33].include?(curr_square)
    curr_square = case community_chest[0]
    when 0 then 0
    when 1 then 10
    else curr_square
    end
    community_chest.push(community_chest.shift)
  # Go to Jail
  elsif curr_square == 30
    curr_square = 10
  end
  distribution[curr_square] += 1
}

p distribution.keys.sort { |b, a| distribution[a] - distribution[b] }
