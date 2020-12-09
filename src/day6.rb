# frozen_string_literal: true

lines = File.readlines("../data/#{__FILE__.split('.')[0]}.txt").map(&:strip)

count = 0
answers = ''

lines.each do |line|
  if line == ''
    count += answers.length
    answers = ''
    next
  end
  if answers == ''
    answers = line.split('').uniq
  else
    answers &= line.split('').uniq
  end
end

puts count
