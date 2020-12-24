# problem 1

input = File.read('24.input').split("\n")

black_tiles = {}

def flip_tile(black_tiles, line)
  y = 0
  x = 0

  while true
    if line.start_with?('se')
      line = line[2..-1]

      y -= 1
      x += 1
    elsif line.start_with?('sw')
      line = line[2..-1]

      y -= 1
      x -= 1
    elsif line.start_with?('nw')
      line = line[2..-1]

      y += 1
      x -= 1
    elsif line.start_with?('ne')
      line = line[2..-1]

      y += 1
      x += 1
    elsif line.start_with?('e')
      line = line[1..-1]

      x += 2
    elsif line.start_with?('w')
      line = line[1..-1]

      x -= 2
    else
      break
    end
  end

  pos = "#{y},#{x}"

  black_tiles[pos] = black_tiles[pos] ? nil : true
end

input.each do |line|
  flip_tile(black_tiles, line)
end

puts black_tiles.compact.count

# problem 2

def count_black_neighbors(black_tiles, y, x)
  [
    [y - 1, x - 1],
    [y + 1, x + 1],
    [y + 1, x - 1],
    [y - 1, x + 1],
    [y + 0, x - 2],
    [y + 0, x + 2]
  ].select do |offset|
    new_y, new_x = offset
    pos = "#{new_y},#{new_x}"

    black_tiles[pos]
  end.count
end

def flip_all(black_tiles)
  new_tiles = {}

  black_tiles.each do |pos, value|
    next unless value

    y, x = pos.split(',')
    y = y.to_i
    x = x.to_i

    [
      [y + 0, x + 0],
      [y - 1, x - 1],
      [y + 1, x + 1],
      [y + 1, x - 1],
      [y - 1, x + 1],
      [y + 0, x - 2],
      [y + 0, x + 2]
    ].each do |offset|
      new_y, new_x = offset
      pos = "#{new_y},#{new_x}"

      if new_tiles[pos].nil?
        black_neighbors_count = count_black_neighbors(black_tiles, new_y, new_x)
        is_black = black_tiles[pos]

        if is_black && (black_neighbors_count == 0 || black_neighbors_count > 2)
          new_tiles[pos] = false
        elsif !is_black && black_neighbors_count == 2
          new_tiles[pos] = true
        else
          new_tiles[pos] = is_black ? true : false
        end
      end
    end
  end

  new_tiles
end

day = 0
while day < 100
  day += 1

  black_tiles = flip_all(black_tiles)
end

puts black_tiles.values.select { |o| o }.count

