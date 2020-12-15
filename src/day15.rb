# frozen_string_literal: true

require 'set'

numbers = File.read("../data/#{__FILE__.split('.')[0]}.txt").strip.split(',')
numbers = numbers.map(&:to_i)

last_seen = {}
last_number = numbers[0]

part1 = 0

30_000_000.times do |turn|
  part1 = last_number if turn == 2020
  if turn < numbers.length
    last_seen[last_number] = turn
    last_number = numbers[turn]
    next
  end

  if last_seen[last_number]
    prev_turn = last_seen[last_number]
    last_seen[last_number] = turn
    last_number = turn - prev_turn
  else
    last_seen[last_number] = turn
    last_number = 0
  end
end

part2 = last_number

puts "Part1: #{part1}"
puts "Part2: #{part2}"
