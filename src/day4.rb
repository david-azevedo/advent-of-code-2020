lines = File.readlines('../data/day4.txt').map { |l| l.gsub(/\R+/, ' ') }

def validate_passport(passport)
  keys = passport.split(' ').map { |p| p.split(':')[0] }
  values = passport.split(' ').map { |p| p.split(':')[1] }

  return false unless keys.include?('byr')
  return false unless keys.include?('iyr')
  return false unless keys.include?('eyr')
  return false unless keys.include?('hgt')
  return false unless keys.include?('hcl')
  return false unless keys.include?('ecl')
  return false unless keys.include?('pid')

  byr = values[keys.index('byr')].to_i
  return false unless byr >= 1920 && byr <= 2002

  iyr = values[keys.index('iyr')].to_i
  return false unless iyr >= 2010 && iyr <= 2020

  eyr = values[keys.index('eyr')].to_i
  return false unless eyr >= 2020 && eyr <= 2030

  hgt = values[keys.index('hgt')]
  hgt_value = hgt[0..-3].to_i

  return false unless hgt.end_with?('cm') || hgt.end_with?('in')

  if hgt.end_with?('cm')
    return false unless hgt_value >= 150 && hgt_value <= 193
  end

  if hgt.end_with?('in')
    return false unless hgt_value >= 59 && hgt_value <= 76
  end

  hcl = values[keys.index('hcl')]
  return false unless hcl.match(/#[0-9a-f]{6}\Z/)

  ecl = values[keys.index('ecl')]
  return false unless ['amb','blu','brn','gry','grn','hzl','oth'].include?(ecl)

  pid = values[keys.index('pid')]
  return false unless pid.match(/\A[0-9]{9}\Z/)

  true
end

current_passport = ''
n_valid = 0
lines.each do |line|
  if line == ' '
    n_valid += 1 if validate_passport(current_passport)
    current_passport = ''
    next
  end
  current_passport += line
end

puts n_valid
