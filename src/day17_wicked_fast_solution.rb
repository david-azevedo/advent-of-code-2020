# frozen_string_literal: true

require 'set'

lines = File.readlines("../data/#{__FILE__[0..4]}.txt")

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

def gen_neighbors_3d(position)
  result = []
  neighbors_3d.each do |offsets|
    next if offsets == [0, 0, 0] # Skip self

    result.append([
                    position[0] + offsets[0],
                    position[1] + offsets[1],
                    position[2] + offsets[2]
                  ])
  end
  result
end

def gen_neighbors_4d(position)
  result = []
  neighbors_4d.each do |offsets|
    next if offsets == [0, 0, 0, 0] # Skip self

    result.append([
                    position[0] + offsets[0],
                    position[1] + offsets[1],
                    position[2] + offsets[2],
                    position[3] + offsets[3]
                  ])
  end
  result
end

# This solution is ridiculously more fast than my solution (44s -> 2s)
# the trick is that we only need to consider the positions which are active
# and their respective neighbors. So here we generate an hashmap of
# position -> neighbor count and use this to evaluate the active positions
# for the next cycle

6.times do
  pos_counts_3d = {}
  pos_counts_4d = {}
  active_3d.each do |active|
    gen_neighbors_3d(active).each do |neighbor|
      if pos_counts_3d[neighbor]
        pos_counts_3d[neighbor] += 1
      else
        pos_counts_3d[neighbor] = 1
      end
    end
  end
  active_4d.each do |active|
    gen_neighbors_4d(active).each do |neighbor|
      if pos_counts_4d[neighbor]
        pos_counts_4d[neighbor] += 1
      else
        pos_counts_4d[neighbor] = 1
      end
    end
  end
  new_active_3d = Set.new
  pos_counts_3d.each do |pos, count|
    if active_3d.include?(pos)
      new_active_3d.add(pos) if [2, 3].include?(count)
    elsif count == 3
      new_active_3d.add(pos)
    end
  end
  new_active_4d = Set.new
  pos_counts_4d.each do |pos, count|
    if active_4d.include?(pos)
      new_active_4d.add(pos) if [2, 3].include?(count)
    elsif count == 3
      new_active_4d.add(pos)
    end
  end
  active_3d = new_active_3d
  active_4d = new_active_4d
end

part1 = active_3d.length
part2 = active_4d.length

puts "Part1: #{part1}"
puts "Part2: #{part2}"
