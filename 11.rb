# problem 1

input = File.read('11.input').split("\n").map(&:chars)

def occupied?(input, y, x)
  return false if y < 0 || x < 0
  return false if y >= input.size || x >= input[0].size

  input[y][x] == '#'
end

def count_occupied(input, y, x)
  [
    [y - 1, x - 1],
    [y - 1, x + 1],
    [y + 1, x + 1],
    [y + 1, x - 1],
    [y - 1, x    ],
    [y + 1, x    ],
    [y    , x - 1],
    [y    , x + 1],
  ].select do |comb|
    occupied?(input, comb[0], comb[1])
  end.count
end

def any_occupied?(input, y, x)
  [
    [y - 1, x - 1],
    [y - 1, x + 1],
    [y + 1, x + 1],
    [y + 1, x - 1],
    [y - 1, x    ],
    [y + 1, x    ],
    [y    , x - 1],
    [y    , x + 1],
  ].any? do |comb|
    occupied?(input, comb[0], comb[1])
  end
end

def mutate(input)
  modified = false

  output = input.map { |r| r.map { |c| c } }

  input.each.with_index do |row, idx1|
    row.each.with_index do |seat_val, idx2|
      next if seat_val == '.'

      if seat_val == 'L' && !any_occupied?(input, idx1, idx2)
        output[idx1][idx2] = '#'
        modified = true
      elsif seat_val == '#' && count_occupied(input, idx1, idx2) >= 4
        output[idx1][idx2] = 'L'
        modified = true
      end
    end
  end

  [output, modified]
end

last_input = nil

while true
  input, modified = mutate(input)
  break unless modified

  last_input = input
end

puts last_input.map { |r| r.select { |c| c == '#' }.count }.sum

# problem 2

input = File.read('11.input').split("\n").map(&:chars)

def out_of_bounds?(input, y, x)
  y < 0 || x < 0 || y >= input.size || x >= input[0].size
end

def count_occupied2(input, y, x)
  sum = 0

  [
    [ 0,  1],
    [ 0, -1],
    [ 1,  1],
    [ 1, -1],
    [-1,  1],
    [-1, -1],
    [ 1,  0],
    [-1,  0]
  ].each do |change|
    y2 = y
    x2 = x

    while true
      y2 += change[0]
      x2 += change[1]

      if out_of_bounds?(input, y2, x2) || input[y2][x2] == 'L'
        break
      elsif input[y2][x2] == '#'
        sum += 1
        break
      end
    end
  end

  sum
end

def any_occupied2?(input, y, x)
  [
    [ 0,  1],
    [ 0, -1],
    [ 1,  1],
    [ 1, -1],
    [-1,  1],
    [-1, -1],
    [ 1,  0],
    [-1,  0]
  ].each do |change|
    y2 = y
    x2 = x

    while true
      y2 += change[0]
      x2 += change[1]

      if out_of_bounds?(input, y2, x2) || input[y2][x2] == 'L'
        break
      elsif input[y2][x2] == '#'
        return true
      end
    end
  end

  false
end

def mutate2(input)
  modified = false

  output = input.map { |r| r.map { |c| c } }

  input.each.with_index do |row, idx1|
    row.each.with_index do |seat_val, idx2|
      next if seat_val == '.'

      if seat_val == 'L' && !any_occupied2?(input, idx1, idx2)
        output[idx1][idx2] = '#'
        modified = true
      elsif seat_val == '#' && count_occupied2(input, idx1, idx2) >= 5
        output[idx1][idx2] = 'L'
        modified = true
      end
    end
  end

  [output, modified]
end

last_input = nil

while true
  input, modified = mutate2(input)
  break unless modified

  last_input = input
end

puts last_input.map { |r| r.select { |c| c == '#' }.count }.sum

