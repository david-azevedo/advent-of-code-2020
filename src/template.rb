# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

part1 = 0
part2 = 0

lines.each do |line|
  puts line
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
