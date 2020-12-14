# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

def convert_floating_to_mem(floating)
  # Generate all possible combinations for the floating points
  perms = [0, 1].repeated_permutation(floating.count('X')).to_a
  # For each combination generate the correct number
  perms.map { |perm| perm.map { |bit| floating.sub('X', bit.to_s) } }
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

def solve(lines, part1)
  bitmask = ''
  memory = {}

  lines.each do |line|
    if line.start_with?('mask')
      bitmask = line.split('=')[1].strip
    elsif line.start_with?('mem')
      address, value = line.split('=').map(&:strip)
      address = address.match(/\[([0-9]*)\]/).captures[0].to_i
      if part1
        value = apply_mask_v1(bitmask, value)
        memory[address] = value
      else
        addresses = apply_mask_v2(bitmask, address)
        addresses.each do |adr| # Write multiple memory addresses at once
          memory[adr] = value.to_i
        end
      end
    end
  end

  memory.values.inject(:+)
end

part1 = solve(lines, true)
part2 = solve(lines, false)

puts "Part1: #{part1}"
puts "Part2: #{part2}"
