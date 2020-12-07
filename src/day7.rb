# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

target = 'shiny gold' 
outter_mappings = {}
inner_mappings = {}

lines.each do |line|
  outter, inner = line.split('contain')
  outter = outter.split(' ')[0..1].join(' ')
  inner = inner.split(',')
               .map { |b| [b.split(' ')[1..2].join(' '), b.split(' ')[0]] }
               .reject { |b| b[0] == 'other bags.' }

  # Building the hash map in different directions depending on the objective
  # Mapping of bags to bags which they are contained in.
  inner.each do |i|
    if inner_mappings[i[0]]
      inner_mappings[i[0]] |= [outter]
    else
      inner_mappings[i[0]] = [outter]
    end
  end

  # Mapping of bags to bags they must contain
  if outter_mappings[outter]
    outter_mappings[outter] |= inner
  else
    outter_mappings[outter] = inner
  end
end

seen_inner = inner_mappings[target]
part1 = seen_inner

while seen_inner.length.positive?
  elem = seen_inner.first
  elems = inner_mappings[elem]
  part1 |= elems || []
  seen_inner |= elems || []
  seen_inner.delete(elem)
end

part1 = part1.length

seen_outter = outter_mappings[target]
part2 = 0
current_mult = 1

while seen_outter.length.positive?
  elem = seen_outter.first
  elems = outter_mappings[elem[0]]

  current_mult = elem[1].to_i
  part2 += current_mult

  new_elems = []
  elems.each do |e|
    new_elems.push([e[0], (current_mult * e[1].to_i).to_s])
  end

  seen_outter.push(*new_elems)
  # Delete only the first occurence
  seen_outter.delete_at(seen_outter.index(elem))
end

puts part1
puts part2
