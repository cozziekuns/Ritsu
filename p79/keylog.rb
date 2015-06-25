passcodes = []
answer = []
behind = {}

# Parse files
File.open("keylog.txt") { |f|
  f.each_line { |line| passcodes.push(line.strip.split("")) }
}

# Create an array for each letter in the front and back hash
passcodes.flatten.uniq.each { |letter| behind[letter] = [] }

passcodes.each { |code|
  # Add each letter that is behind the current letter to the
  # letter's behind list in the hash
  code.each_with_index { |s, i| behind[s] += code[0...i] }
}

behind.values.each { |value| value.uniq! }
# Sort ascendingly by how many letters are behind
p behind.keys.sort { |a, b| behind[a].size - behind[b].size }.join
