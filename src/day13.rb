# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

earliest = lines[0].to_i
buses = lines[1].strip.split(',')
buses_cleaned = buses.reject { |b| b == 'x' }.map(&:to_i)
wait_times = buses_cleaned.map { |b| b - (earliest % b) }

part1 = buses_cleaned[wait_times.index(wait_times.min)] * wait_times.min

# Chinese Remainder Theorem arrays
# This only works because all ni are prime, making them coprime between each other.
ni = []
ai = []
buses.length.times do |i|
  next if buses[i] == 'x'

  value = buses[i].to_i
  ni.append(value)
  ai.append(i % value)
end

# This is Search by sieving https://en.wikipedia.org/wiki/Chinese_remainder_theorem#Search_by_sieving
# We find the first timestamp where n1 and n2 match the criteria them increment by lcm = LCM(n1,n2) until
# we find a timestamp where the criteria for n3 is also met. We then update lcm to be LCM(lcm, n3) and
# continue to increment until the criteria for n4 is also met. So on until all constraints are met.
lcm = part2 = ni[0]
ni.length.times do |i|
  loop do
    break if ((part2 + ai[i]) % ni[i]).zero?

    part2 += lcm
  end
  lcm = lcm.lcm(ni[i])
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
