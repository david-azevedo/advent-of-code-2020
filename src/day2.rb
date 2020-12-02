values = File.readlines('../data/day2.txt')

valid_passwords = 0

values.each do |value|
  info = value.split(' ')
  range = info[0].split('-').map(&:to_i)
  letter = info[1][0]
  password = info[2]

  # count = password.count(letter)
  valid_passwords += 1 if (password[range[0] - 1] == letter) ^ (password[range[1] - 1] == letter)
end

puts valid_passwords
