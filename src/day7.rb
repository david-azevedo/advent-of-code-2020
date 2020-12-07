# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt")

mappings = {}

lines.each do |line|
  outter, inner = line.split('contain')
  outter = outter.split(' ')[0..1].join(' ')
  inner = inner.split(',')
               .map { |b| [b.split(' ')[1..2].join(' '), b.split(' ')[0]] }
               .reject { |b| b[0] == 'other bags.' }

  # Building the hash map in different directions depending on the objective
  # Mapping of bags to bags which they are contained in.
  # inner.each do |i|
  #   if mappings[i]
  #     mappings[i] |= [outter]
  #   else
  #     mappings[i] = [outter]
  #   end
  # end

  # Mapping of bags to bags they must contain
  if mappings[outter]
    mappings[outter] |= inner
  else
    mappings[outter] = inner
  end
end

seen = mappings['shiny gold'].clone
total_count = 0
current_mult = 1

while seen.length.positive?
  elem = seen.first
  elems = mappings[elem[0]]

  current_mult = elem[1].to_i
  total_count += current_mult

  new_elems = []
  elems.each do |e|
    new_elems.push([e[0], (current_mult * e[1].to_i).to_s])
  end

  seen.push(*new_elems)
  # Delete only the first occurence
  seen.delete_at(seen.index(elem))
end

puts total_count
