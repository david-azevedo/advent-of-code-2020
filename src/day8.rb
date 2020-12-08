# frozen_string_literal: true

require 'set'

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

# Apply the instruction to a given pair of accumulator and offset
def run_instruction(line, acc, offset)
  instruction, value = line.split(' ') # "acc +14" -> ["acc", "+14"]

  case instruction
  when 'acc'
    [acc + value.to_i, offset + 1]
  when 'jmp'
    [acc, offset + value.to_i]
  when 'nop'
    [acc, offset + 1]
  end
end

# Run the program until we either reach the end or find a repeated instruction
def run_program(lines)
  acc = 0
  offset = 0
  offsets_seen = Set.new # Keeping track of all the offsets we have seen so far

  loop do
    # If we reach the end they return the accumulator and 'terminated' status
    return acc, 'terminated' if offset >= lines.length || offset.negative?

    # If we see a repeat instruction (loop found) return the accumulator
    # and the list of seen instructions
    return acc, offsets_seen.to_a if offsets_seen.include?(offset)

    offsets_seen << offset # Add this offset to our list of seen offsets

    # Update the accumulator and offset by running the instruction
    acc, offset = run_instruction(lines[offset], acc, offset)
  end
end

# Part 2: Iterating through all the seen instructions in the first run and
# editing one by one and checking if that swap makes the program terminate.
# If so we have found the solution.
def fix_bad_instruction(lines, to_change)
  to_change.each do |index|
    # This is copying the array if we simply do 'new_lines = lines' then lines
    # will also be changed when we change new_lines
    new_lines = lines.map(&:clone)
    new_lines[index][0..2] = 'nop' if lines[index].start_with?('jmp')
    new_lines[index][0..2] = 'jmp' if lines[index].start_with?('nop')

    part2, result = run_program(new_lines)
    return part2 if result == 'terminated'
  end
end

part1, to_change = run_program(lines)
part2 = fix_bad_instruction(lines, to_change)

puts "Part1: #{part1}"
puts "Part2: #{part2}"
