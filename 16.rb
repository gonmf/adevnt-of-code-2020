# problem 1

input = File.read('16.input').split("\n").select { |s| s.size > 0 }

stage = 0
my_ticket = nil
nearby_tickets = []
fields = {}

def parse_values(line)
  name, values = line.split(': ')

  values = values.split(' or ')

  values = values.map { |v| v.split('-').map(&:to_i) }

  [name, values]
end

input.each do |line|
  if stage == 0
    if line == 'your ticket:'
      stage = 1
      next
    end

    name, ranges = parse_values(line)

    fields[name] = ranges
  elsif stage == 1
    my_ticket = line.split(',').map(&:to_i)
    stage = 2
  else
    next if line == 'nearby tickets:'

    nearby_tickets.push(line.split(',').map(&:to_i))
  end
end

ticket_scanning_error_rate = 0

nearby_tickets.each do |nearby_ticket|
  nearby_ticket.each do |val|
    valid = fields.values.any? do |ranges|
      ranges.any? do |range|
        l, h = range

        l <= val && val <= h
      end
    end

    ticket_scanning_error_rate += val unless valid
  end
end

puts ticket_scanning_error_rate

# problem 2

new_nearby_tickets = []

nearby_tickets.each do |nearby_ticket|
  valid = nearby_ticket.all? do |val|
    fields.values.any? do |ranges|
      ranges.any? do |range|
        l, h = range

        l <= val && val <= h
      end
    end
  end

  new_nearby_tickets.push(nearby_ticket) if valid
end


nearby_tickets = new_nearby_tickets

def all_values_fit_in_ranges?(values, ranges)
  values.all? do |value|
    ranges.any? do |range|
      min, max = range

      min <= value && value <= max
    end
  end
end

solution = Array.new(my_ticket.size, nil)
any_modified = true

while any_modified
  any_modified = false
  available_names = fields.keys - solution.compact

  solution.each.with_index do |name, idx|
    next if name

    values = nearby_tickets.map { |t| t[idx] }

    fitting_names = []

    available_names.each do |available_name|
      ranges = fields[available_name]

      if all_values_fit_in_ranges?(values, ranges)
        fitting_names.push(available_name)
      end
    end

    if fitting_names.size == 1
      solution[idx] = fitting_names.first
      any_modified = true
      break
    end
  end
end

result = 1

my_ticket.each.with_index do |val, idx|
  result *= val if solution[idx]&.start_with?('departure')
end

puts result
