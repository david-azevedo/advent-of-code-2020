# frozen_string_literal: true

require 'set'

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:strip)

puts 'Go grab a coffe this will take a while! It took around 2min:10.60sec on my machine'

# Only the positions of the active cubes are relevant
active_3d = Set.new
active_4d = Set.new

lines.each_with_index do |line, row|
  line.split('').each_with_index do |char, col|
    active_3d.add([row, col, 0]) if char == '#'
    active_4d.add([row, col, 0, 0]) if char == '#'
  end
end

def neighbors_3d
  [-1, 0, 1].repeated_permutation(3).to_a
end

def neighbors_4d
  [-1, 0, 1].repeated_permutation(4).to_a
end

def count_neighbors_4d(row, col, z_axis, w_axis, active)
  count = 0
  neighbors_4d.each do |offsets|
    next if offsets == [0, 0, 0, 0] # Skip self

    new_r = row + offsets[0]
    new_c = col + offsets[1]
    new_z = z_axis + offsets[2]
    new_w = w_axis + offsets[3]
    count += 1 if active.include?([new_r, new_c, new_z, new_w])
  end
  count
end

def count_neighbors_3d(row, col, z_axis, active)
  count = 0
  neighbors_3d.each do |offsets|
    next if offsets == [0, 0, 0] # Skip self

    new_r = row + offsets[0]
    new_c = col + offsets[1]
    new_z = z_axis + offsets[2]
    count += 1 if active.include?([new_r, new_c, new_z])
  end
  count
end

6.times do
  new_active_3d = Set.new
  new_active_4d = Set.new
  (-13..13).each do |row|
    (-13..13).each do |col|
      (-6..6).each do |z_axis|
        # For every position (row, col, z_axis)
        current_pos = [row, col, z_axis]
        neighbors = count_neighbors_3d(row, col, z_axis, active_3d)
        if active_3d.include?(current_pos)
          new_active_3d.add(current_pos) if [2, 3].include?(neighbors)
        elsif neighbors == 3
          new_active_3d.add(current_pos)
        end
        (-6..6).each do |w_axis|
          # For every position (row, col, z_axis, w_axis)
          current_pos = [row, col, z_axis, w_axis]
          neighbors = count_neighbors_4d(row, col, z_axis, w_axis, active_4d)
          if active_4d.include?(current_pos)
            new_active_4d.add(current_pos) if [2, 3].include?(neighbors)
          elsif neighbors == 3
            new_active_4d.add(current_pos)
          end
        end
      end
    end
  end
  active_3d = new_active_3d
  active_4d = new_active_4d
end

# This problem is a reference to Conway's Game of Life
# https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life - very interesting read

part1 = active_3d.length
part2 = active_4d.length

puts "Part1: #{part1}"
puts "Part2: #{part2}"
