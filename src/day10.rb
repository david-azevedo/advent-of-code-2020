# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:to_i)

# Lessons learned
# (0..n) is inclusive and will also output n
# (0...n) is not inclusive and will not output n

def count_differences(sorted)
  diff_count = { 0 => 0, 1 => 0, 2 => 0, 3 => 0 }
  (0...sorted.length - 1).each do |i|
    diff = sorted[i + 1] - sorted[i]
    break if diff > 3

    diff_count[diff] += 1
  end
  diff_count
end

@memo = {} # Caching results for better performance
# Calculate the number of possible solutions from index
# to the end of sorted by summing the number of solutions
# of all solutions for the numbers in front. If we are at
# the last index then the answer is 1.
def memoization(sorted, index)
  return 1 if index == sorted.length - 1
  return @memo[index] if @memo[index]

  ans = 0
  (index + 1...sorted.length).each do |j|
    break unless sorted[j] - sorted[index] <= 3

    ans += memoization(sorted, j)
  end
  @memo[index] = ans
  ans
end

sorted = lines.push(0).sort
sorted.push(sorted[-1] + 3)
sum_diff = count_differences(sorted)

part1 = sum_diff[1] * sum_diff[3]
part2 = memoization(sorted, 0)

puts "Part1: #{part1}"
puts "Part2: #{part2}"
