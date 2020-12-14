# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

def convert_floating_to_mem(floating)
  float_count = floating.count('X')

  perms = [0, 1].repeated_permutation(float_count).to_a
  result = []
  perms.each do |perm|
    value = floating
    perm.each do |bit|
      value = value.sub('X', bit.to_s)
    end
    result.append(value.to_i(2))
  end

  result
end

def apply_mask_v2(mask, value)
  return 0 if mask == ''

  binary = value.to_i.to_s(2)
  binary.prepend('0') while mask.length > binary.length

  result = '0' * binary.length
  binary.length.times do |i|
    result[i] = mask[i] if mask[i] == '1'
    result[i] = binary[i] if mask[i] == '0'
    result[i] = mask[i] if mask[i] == 'X'
  end

  convert_floating_to_mem(result)
end

def apply_mask_v1(mask, value)
  return 0 if mask == ''

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
    addresses.each do |adr|
      memory[adr] = value.to_i
    end
  end
end

part2 = memory.values.inject(:+)

puts "Part1: #{part1}"
puts "Part2: #{part2}"
