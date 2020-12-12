# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

def rotate_left(offset, east, north)
  offset.times do
    east, north = north, east
    east = -east
  end
  [east, north]
end

east = 10 # Change to 0 for part 1 and 10 for part 2
north = 1 # Change to 0 for part 1 and 1 for part 2
# direction = 0 # Uncomment for part 1
ship_north = 0
ship_east = 0

lines.each do |line|
  letter = line[0]
  num = line[1..-1].to_i
  case letter
  when 'N'
    north += num
  when 'S'
    north -= num
  when 'E'
    east += num
  when 'W'
    east -= num
  when 'L'
    east, north = rotate_left((num % 360) / 90, east, north)
    # direction += ((num % 360) / 90) # Uncomment for part 1
    # direction %= 4 # Uncomment for part 1
  when 'R'
    east, north = rotate_left(4 - ((num % 360) / 90), east, north)
    # direction += 4 - ((num % 360) / 90) # Uncomment for part 1
    # direction %= 4 # Uncomment for part 1
  when 'F'
    ship_east += east * num
    ship_north += north * num
    # case direction # Uncomment for part 1
    # when 0
    #   east += num
    # when 1
    #   north += num
    # when 2
    #   east -= num
    # when 3
    #   north -= num
    # end
  end
end

part1 = east.abs + north.abs
part2 = ship_east.abs + ship_north.abs

puts "Part1: #{part1}"
puts "Part2: #{part2}"
