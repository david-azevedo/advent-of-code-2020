# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

earliest = lines[0].to_i
buses = lines[1].strip.split(',').reject { |b| b == 'x' }.map(&:to_i)
bus_waiting_time = buses.map { |b| b - (earliest % b) }
min_waiting = bus_waiting_time.min
bus_with_min_waiting = buses[bus_waiting_time.index(min_waiting)]

part1 = bus_with_min_waiting * min_waiting

# Testing if num is solution to the given constraints
def solution?(num, ni, ai)
  ni.length.times do |i|
    return false unless num % ni[i] == ai[i]
  end
  true
end

# extended Euclidean algorithm used to compute Mi and mi
def extended_gcd(a, b)
  old_r = a
  r = b
  old_s = t = 1
  s = old_t = 0
  while r != 0
    quotient = old_r / r
    old_r, r = r, old_r - quotient * r
    old_s, s = s, old_s - quotient * s
    old_t, t = t, old_t - quotient * t
  end
  [old_s, old_t]
end

buses = lines[1].strip.split(',')
# Chinese Remainder Theorem arrays
ni = []
ai = []
buses.length.times do |i|
  next if buses[i] == 'x'

  value = buses[i].to_i
  ni.append(value)
  ai.append(i % value)
end

# This number represents the number of minutes between
# each consecutive occurence of the constraints 
N = ni.inject(:*)

sum = 0
ni.length.times do |i|
  # ai * Ni * Mi
  sum += ai[i] * (N / ni[i]) * extended_gcd(N / ni[i], ni[i])[0]
end

# Reduce sum to be < N
sum %= N

# Smallest positive solution is N - Sum(ai * Ni * Mi)
part2 = N - sum

puts "Part1: #{part1}"
puts "Part2: #{part2}"
