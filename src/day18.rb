# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

# Neaty little trick, we want + and * to have the same function
# as normal but with equal precedence. So we change all * to -
# effectively giving them the same precedence. We them override
# the subtraction operator on all Integers to work as multiplication
# Rube Precendece Table - https://ruby-doc.org/core-2.7.2/doc/syntax/precedence_rdoc.html
class Integer
  # For part 1 we want to give * the same precedence as +
  def -(other)
    self * other
  end

  # For part 2 we want + to have a higher precedence than *
  # Since ** has a higher precedence we can use that
  def **(other)
    self + other
  end
end

part1 = 0
part2 = 0

lines.each do |line|
  part1 += eval(line.gsub('*', '-'))
end

lines.each do |line|
  part2 += eval(line.gsub('+', '**'))
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
