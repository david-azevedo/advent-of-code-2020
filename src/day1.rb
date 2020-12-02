values = File.readlines('../data/day1.txt').map(&:to_i)

# Brute force solution
pairs = values.permutation(3).to_a

pairs.each do |x|
  if x[0] + x[1] + x[2] == 2020
    puts x[0] * x[1] * x[2]
    break
  end 
end

#Big brain solution - Part 1
# values.each do |x|
#   if values.include?(2020 - x)
#     puts x * (2020 - x)
#     break
#   end
# end