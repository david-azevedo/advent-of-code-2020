# frozen_string_literal: true

require 'set'

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:strip)

def adjacents
  [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]
end

def count_adjacent_part1(matrix, row, col)
  count = 0
  adjacents.each do |adjacent|
    r = row + adjacent[0]
    c = col + adjacent[1]
    next unless r < matrix.length && r >= 0 && c < matrix[0].length && c >= 0

    count += 1 if matrix[r][c] == '#'
  end
  count
end

def count_adjacent_part2(matrix, row, col)
  rows = matrix.length
  cols = matrix[0].length
  count = 0
  adjacents.each do |adjacent|
    r = row + adjacent[0]
    c = col + adjacent[1]
    # Follow the slope until we find a seat or reach the edge
    while r < rows && r >= 0 && c < cols && c >= 0
      if matrix[r][c] == '#'
        count += 1
        break
      end
      break if matrix[r][c] == 'L'

      r += adjacent[0]
      c += adjacent[1]
    end
  end
  count
end

def count_adjacent(lines, row, col, threshold)
  return count_adjacent_part1(lines, row, col) if threshold == 4

  count_adjacent_part2(lines, row, col)
end

def update_matrix(lines, threshold)
  new_matrix = lines.map(&:clone)

  lines.length.times do |r|
    lines[0].length.times do |c|
      next if lines[r][c] == '.'

      occupied = count_adjacent(lines, r, c, threshold)

      new_matrix[r][c] = '#' if lines[r][c] == 'L' && occupied.zero?
      new_matrix[r][c] = 'L' if lines[r][c] == '#' && occupied >= threshold
    end
  end
  new_matrix
end

def print_matrix(matrix)
  matrix.each do |line|
    puts line
  end
end

def update_until_seen(lines, threshold)
  seen = Set.new
  loop do
    lines = update_matrix(lines, threshold)
    break if seen.include?(lines.join)

    seen.add(lines.join)
  end
  lines
end

part1 = update_until_seen(lines, 4).join.count('#')
part2 = update_until_seen(lines, 5).join.count('#')

puts "Part1: #{part1}"
puts "Part2: #{part2}"
