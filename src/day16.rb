# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

# Check if the value is valid for any of the constraints
def valid_for_rules?(number, rules)
  rules.values.each do |ranges|
    ranges.each do |range|
      return true if number >= range[0] && number <= range[1]
    end
  end
  false
end

# Return an array with all the rules that this number is valid in
def matching_rules(number, rules)
  result = []
  rules.each do |rule, ranges|
    valid = false
    ranges.each do |range|
      valid = true if number >= range[0] && number <= range[1]
    end
    result.append(rule) if valid
  end
  result
end

# State machine to parse input
state = 0
rules = {}
my_ticket = []
other_tickets = []

lines.each do |line| # Input parsing
  if line == "\n" # Move to next state when a blank line is found
    state += 1
    next
  end

  case state
  when 0 # Rule parsing
    rule_name, ranges = line.split(': ')
    ranges = ranges.split(' or ').map { |r| r.split('-').map(&:to_i) }
    rules[rule_name] = ranges
  when 1 # My ticket
    unless line.start_with?('your ticket')
      my_ticket = line.split(',').map(&:to_i)
    end
  when 2 # Other tickets
    unless line.start_with?('nearby tickets')
      other_tickets.append(line.split(',').map(&:to_i))
    end
  else
    puts 'This should not happen'
  end
end

part1 = 0
valid_other_tickets = []

# Drop any ticket that has at least 1 number that is not valid
# for any rule. For each such number add it to part 1 result
other_tickets.each do |ticket|
  valid = true
  ticket.each do |number|
    unless valid_for_rules?(number, rules)
      valid = false
      part1 += number
    end
  end
  valid_other_tickets.append(ticket) if valid
end

possibilities = {}

# For every valid ticket build a list of possible field names.
valid_other_tickets.each do |ticket|
  ticket.each_with_index do |number, index|
    rules_matching = matching_rules(number, rules)
    if possibilities[index]
      possibilities[index] &= rules_matching
    else
      possibilities[index] = rules_matching
    end
  end
end

seen = []
correct_name = {}

# Follow the possibilities and create the correct name for each
# value by exclusion
while seen.length < my_ticket.length
  possibilities.each do |index, rule_list|
    aux = rule_list - seen
    if aux.length == 1
      correct_name[index] = aux[0]
      seen.append(aux[0])
    end
  end
end

part2 = 1

# Multiply all the value of the fields that start with Departure
correct_name.each do |index, rule_name|
  part2 *= my_ticket[index] if rule_name.start_with?('departure')
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
