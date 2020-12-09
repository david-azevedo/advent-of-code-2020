# frozen_string_literal: true

lines = File.readlines('../data/day3.txt').map { |l| l.strip.split('') }

vertical_size = lines.length
horizontal_size = lines[0].length
slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
result = 1

slopes.each do |slope|
  pos_h = 0
  pos_v = 0
  n_trees = 0
  slope_h = slope[0]
  slope_v = slope[1]

  lines.each do |_line|
    break if pos_v >= vertical_size

    n_trees += 1 if lines[pos_v][pos_h % horizontal_size] == '#'

    pos_h += slope_h
    pos_v += slope_v
  end

  result *= n_trees
end

puts result
