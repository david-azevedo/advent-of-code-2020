# frozen_string_literal: true

numbers = File.read("../data/#{__FILE__.split('.')[0]}.txt").strip.split(',')
numbers = numbers.map(&:to_i)

part1 = 0
last_seen = {}
number = numbers[0]

30_000_000.times do |turn|
  part1 = number if turn == 2020
  if turn < numbers.length
    last_seen[number] = turn
    number = numbers[turn]
    next
  end

  if last_seen[number]
    prev_turn = last_seen[number]
    last_seen[number] = turn
    number = turn - prev_turn
  else
    last_seen[number] = turn
    number = 0
  end
end

part2 = number

puts "Part1: #{part1}"
puts "Part2: #{part2}"
