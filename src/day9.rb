# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:to_i)

def find_pair_sum(numbers, num)
  numbers.each do |number|
    if numbers.include?(num - number)
      return true unless num == num - number
    end
  end
  false
end

def find_invalid(lines, preamble)
  lines.length.times do |index|
    next if index < preamble

    next if find_pair_sum(lines[index - preamble, index], lines[index])

    return lines[index]
  end
end

def contiguous_sum(lines, num)
  start = 0
  finish = 1
  while finish < lines.length
    sum = lines[start..finish].inject(:+)
    return lines[start..finish] if sum == num

    start += 1 if sum > num
    finish += 1 if sum < num
  end
end

part1 = find_invalid(lines, 25)
sub_array = contiguous_sum(lines, part1)
part2 = sub_array.min + sub_array.max

puts "Part1: #{part1}"
puts "Part2: #{part2}"
