# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

def convert_floating_to_mem(floating)
  # Generate all possible combinations for the floating points
  perms = [0, 1].repeated_permutation(floating.count('X')).to_a
  result = []
  # For each combination generate the correct number
  perms.each do |perm|
    value = floating
    perm.each do |bit|
      # This works because sub substitutes only the first occurence
      # while gsub substitutes all occurences
      value = value.sub('X', bit.to_s)
    end
    result.append(value.to_i(2))
  end

  result
end

def apply_mask_v2(mask, value)
  binary = value.to_i.to_s(2)
  binary.prepend('0') while mask.length > binary.length

  result = '0' * binary.length
  binary.length.times do |i|
    result[i] = mask[i]
    result[i] = binary[i] if mask[i] == '0'
  end

  convert_floating_to_mem(result)
end

def apply_mask_v1(mask, value)
  binary = value.to_i.to_s(2)
  binary.prepend('0') while mask.length > binary.length

  result = '0' * binary.length
  binary.length.times do |i|
    result[i] = binary[i]
    result[i] = mask[i] if mask[i] != 'X'
  end

  result.to_i(2)
end

bitmask = ''
memory = {}

# Part 1
lines.each do |line|
  if line.start_with?('mask')
    bitmask = line.split('=')[1].strip
  elsif line.start_with?('mem')
    address, value = line.split('=').map(&:strip)
    address = address.match(/\[([0-9]*)\]/).captures[0].to_i
    value = apply_mask_v1(bitmask, value)
    memory[address] = value
  end
end

part1 = memory.values.inject(:+)
bitmask = ''
memory = {}

# Part 2
lines.each do |line|
  if line.start_with?('mask')
    bitmask = line.split('=')[1].strip
  elsif line.start_with?('mem')
    address, value = line.split('=').map(&:strip)
    address = address.match(/\[([0-9]*)\]/).captures[0].to_i
    addresses = apply_mask_v2(bitmask, address)
    addresses.each do |adr| # Write multiple memory addresses at once
      memory[adr] = value.to_i
    end
  end
end

part2 = memory.values.inject(:+)

puts "Part1: #{part1}"
puts "Part2: #{part2}"
