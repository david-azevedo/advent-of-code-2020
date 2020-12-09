# frozen_string_literal: true

require 'set'

filename = "../data/#{__FILE__.split('.')[0]}.txt"
values = File.readlines(filename).map(&:to_i).to_set

def part1(values, target)
  values.each do |x|
    return x * (target - x) if values.include?(target - x)
  end
  nil
end

def part2(values, target)
  values.each do |x|
    complement = target - x
    result = part1(values, complement)
    return result * x if result
  end
end

part1 = part1(values, 2020)
part2 = part2(values, 2020)

puts "Part1: #{part1}"
puts "Part2: #{part2}"
