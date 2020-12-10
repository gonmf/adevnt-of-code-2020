# problem 1

def seat(text)
  row = text[0..6]
  col = text[7..]

  row = row.gsub('B', '1').gsub('F', '0').to_i(2)
  col = col.gsub('R', '1').gsub('L', '0').to_i(2)

  seat_id = row * 8 + col

  [row, col, seat_id]
end

input = File.read('05.input')

max_seat_id = nil

input.split("\n").each do |boarding_pass|
  row, col, seat_id = seat(boarding_pass)

  max_seat_id = [max_seat_id || seat_id, seat_id].max
end

puts max_seat_id

# problem 2

all_seat_ids = input.split("\n").map do |boarding_pass|
  row, col, seat_id = seat(boarding_pass)

  seat_id
end.sort

missing_seats = ((all_seat_ids.first)..(all_seat_ids.last)).to_a - all_seat_ids

puts missing_seats
