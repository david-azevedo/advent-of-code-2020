# frozen_string_literal: true

require 'set'

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:to_i)

def find_pair_sum(numbers, num)
  pairs = []
  numbers = numbers.to_set
  numbers.each do |number|
    if numbers.include?(num - number)
      pairs.push([num, num - number]) unless num == num - number
    end
  end
  pairs
end

def contiguous_sum(lines, num)
  lines.length.times do |index|
    aux = index + 1
    sub_array = [lines[index]]
    sum = lines[index]
    while aux < lines.length
      sum += lines[aux]
      sub_array.push(lines[aux])

      return sub_array if sum == num

      break if sum > num

      aux += 1
    end
  end
end

preamble = 25
part1 = 0

lines.length.times do |index|
  next if index < preamble

  pairs = find_pair_sum(lines[index - preamble, index], lines[index])
  if pairs.empty?
    part1 = lines[index]
    break
  end
end

sub_array = contiguous_sum(lines, part1)
part2 = sub_array.min + sub_array.max

puts "Part1: #{part1}"
puts "Part2: #{part2}"
