lines = File.readlines('../data/day5.txt')

max_seat_id = 0
min_seat_id = 999
seats = Array.new

lines.each do |line|
  binary_row = line.gsub('F','0').gsub('L','0').gsub('B','1').gsub('R','1')
  seat_id = binary_row.to_i(2)
  seats.push(seat_id)
  max_seat_id = seat_id if max_seat_id < seat_id
  min_seat_id = seat_id if min_seat_id > seat_id
end

all_seats = [*min_seat_id..max_seat_id]
puts all_seats - seats

puts max_seat_id
