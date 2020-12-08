# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

# Run the program until we either reach the end or find a repeated instruction
def run_program(lines)
  acc = 0
  offset = 0
  offsets_seen = {}
  # Small otimization for Part 2 only storing jmp and nop instructions
  # that might be incorrect
  instructions_to_change = []

  loop do
    return acc, 'terminated' if offset >= lines.length

    return acc, instructions_to_change if offsets_seen[offset]

    offsets_seen[offset] = 1
    ins, value = lines[offset].split(' ')

    case ins
    when 'acc'
      acc += value.to_i
    when 'jmp'
      instructions_to_change.push(offset)
      offset += value.to_i
      next
    when 'nop'
      instructions_to_change.push(offset)
    end
    # Next instruction
    offset += 1
  end
end

part1, to_change = run_program(lines)

puts "Part1: #{part1}"

# Part 2: Iterating through all the seen instructions in the first run and
# editing one by one and checking if that swap makes the program terminate.
# If so we have found the solution.
to_change.each do |index|
  # This is copying the array if we simply do 'new_lines = lines' then lines
  # will also be changed when we change new_lines
  new_lines = lines.map(&:clone)
  new_lines[index][0..2] = 'nop' if lines[index].start_with?('jmp')
  new_lines[index][0..2] = 'jmp' if lines[index].start_with?('nop')

  part2, result = run_program(new_lines)
  if result == 'terminated'
    puts "Part2: #{part2}"
    break
  end
end
