lines = File.readlines('../data/day5.txt')

max_seat_id = 0
seats = Array.new
lines.each do |line|
  row = line.strip.split('')

  upper_bound = 127
  lower_bound = 0
  upper_column = 7
  lower_column = 0
  row.each do |char|
    case char
    when 'F'
      upper_bound -= (upper_bound - lower_bound) / 2
    when 'B'
      lower_bound += (upper_bound - lower_bound) / 2
    when 'R'
      lower_column += (upper_column - lower_column) / 2
    else
      upper_column -= (upper_column - lower_column) / 2
    end
  end

  seat_id = upper_bound * 8 + upper_column
  seats.push(seat_id)
  max_seat_id = seat_id if max_seat_id < seat_id
end

seats = seats.sort

seats.each_with_index do |seat, index|
  next if index + 1 >= seats.length 
  if seats[index + 1] - seat == 2
    if seats.count(seat + 9) == 1
      puts seat + 1
    end
  end 
end

puts max_seat_id
