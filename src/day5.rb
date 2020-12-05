lines = File.readlines('../data/day5.txt')

max_seat_id = 0
seats = Array.new
lines.each do |line|
  row = line.strip.split('')

  seat_row = 0
  seat_col = 0
  row_n = 64
  col_n = 4
  row.each do |char|
    case char
    when 'F'
      row_n /= 2
    when 'B'
      seat_row += row_n
      row_n /= 2
    when 'R'
      seat_col += col_n
      col_n /= 2 
    else
      col_n /= 2 
    end
  end

  seat_id = seat_row * 8 + seat_col
  seats.push(seat_id)
  max_seat_id = seat_id if max_seat_id < seat_id
end

seats_sorted = seats.sort

seats_sorted.each_with_index do |seat, index|
  next if index + 1 >= seats.length 
  if seats_sorted[index + 1] - seat == 2
    puts seat + 1
  end 
end

puts max_seat_id
