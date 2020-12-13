# problem 1

earliest_timestamp, bus_ids, _ = File.read('13.input').split("\n")

earliest_timestamp = earliest_timestamp.to_i
bus_ids = bus_ids.split(',').reject { |id| id == 'x' }.map(&:to_i)

earliest_bus_id = nil
earliest_bus_ts = nil

bus_ids.each do |id|
  ts = (earliest_timestamp / id) * id

  if (earliest_timestamp % id) > 0
    ts += id
  end

  if earliest_bus_ts.nil? || earliest_bus_ts > ts
    earliest_bus_id = id
    earliest_bus_ts = ts
  end
end

puts earliest_bus_id * (earliest_bus_ts - earliest_timestamp)

# problem 2

_, bus_ids, _ = File.read('13.input').split("\n")

bus_ids = bus_ids.split(',').map { |id| id == 'x' ? nil : id.to_i }

bus_ids = bus_ids.map.with_index { |id, idx| id.nil? ? nil : [id, idx] }.compact

t = 0
acc = 1

bus_ids.each do |a|
  id, offset = a

  while ((t + offset) % id) > 0
    t += acc
  end

  acc *= id
end

puts t
