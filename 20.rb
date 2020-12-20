# problem 1

input = File.read('20.input').split("\n")

tiles0 = {}
tiles1 = {}
tiles2 = {}
tiles3 = {}
tiles4 = {}
tiles5 = {}
tiles6 = {}
tiles7 = {}

new_tile_nr = nil
new_tile_contents = []

def deep_clone(obj)
  if obj.is_a?(Array)
    obj.map { |o| deep_clone(o) }
  else
    obj
  end
end

def rotate(contents)
  new_contents = deep_clone(contents)

  contents.each.with_index do |row, y|
    row.each.with_index do |value, x|
      new_x = y
      new_y = contents.count - 1 - x

      new_contents[new_y][new_x] = value
    end
  end

  new_contents
end

def flip(contents)
  new_contents = deep_clone(contents)

  contents.each.with_index do |row, y|
    row.each.with_index do |value, x|
      new_x = contents.count - 1 - x
      new_y = y

      new_contents[new_y][new_x] = value
    end
  end

  new_contents
end

input.push('')
input.each do |line|
  if line.start_with?('Tile ')
    new_tile_nr = line.sub('Tile ', '').sub(':', '').to_i
  elsif line.size > 0
    new_tile_contents.push(line.chars)
  else
    tiles0[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = rotate(new_tile_contents)

    tiles1[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = rotate(new_tile_contents)

    tiles2[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = rotate(new_tile_contents)

    tiles3[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = flip(new_tile_contents)

    tiles4[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = rotate(new_tile_contents)

    tiles5[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = rotate(new_tile_contents)

    tiles6[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = rotate(new_tile_contents)

    tiles7[new_tile_nr] = {
      top: new_tile_contents.first.join,
      bottom: new_tile_contents.last.join,
      left: new_tile_contents.map(&:first).join,
      right: new_tile_contents.map(&:last).join,
      contents: new_tile_contents
    }

    new_tile_contents = []
  end
end

matrix_len = Math.sqrt(tiles0.count).to_i
matrix = Array.new(matrix_len, Array.new(matrix_len, nil))

def count_neighbors(matrix, y, x)
  count = 0

  if y > 0
    if matrix[y - 1][x]
      count += 2
    end
  else
    count += 1
  end

  if y > 0
    if matrix[y][x - 1]
      count += 2
    end
  else
    count += 1
  end

  matrix_len = matrix.count

  if y < matrix_len - 1
    if matrix[y + 1][x]
      count += 2
    end
  else
    count += 1
  end

  if x < matrix_len - 1
    if matrix[y][x + 1]
      count += 2
    end
  else
    count += 1
  end

  count
end

def enumerate_locations(matrix)
  ret = []

  matrix.each.with_index do |row, y|
    row.each.with_index do |col, x|
      if col.nil?
        neighbors_count = count_neighbors(matrix, y, x)

        ret.push([y, x, neighbors_count])
      end
    end
  end

  ret.sort_by { |a| -a[2] }.map { |a| [a[0], a[1]] }
end

def tile_fits?(matrix, y, x, tile)
  if y > 0
    top_tile = matrix[y - 1][x]
    return false unless top_tile.nil? || top_tile[:bottom] == tile[:top]
  end

  if x > 0
    left_tile = matrix[y][x - 1]
    return false unless left_tile.nil? || left_tile[:right] == tile[:left]
  end

  matrix_len = matrix.count

  if y < matrix_len - 1
    bottom_tile = matrix[y + 1][x]
    return false unless bottom_tile.nil? || bottom_tile[:top] == tile[:bottom]
  end

  if x < matrix_len - 1
    right_tile = matrix[y][x + 1]
    return false unless right_tile.nil? || right_tile[:left] == tile[:right]
  end

  true
end

def rec_search(tiles, matrix, tiles_left)
  return matrix if tiles_left.count == 0

  enumerate_locations(matrix).all? do |arr|
    y, x = arr

    tiles_left.any? do |tile_nr|
      new_tiles_left = tiles_left - [tile_nr]

      [0, 1, 2, 3, 4, 5, 6, 7].any? do |rotation|
        if tile_fits?(matrix, y, x, tiles[rotation][tile_nr])
          new_matrix = deep_clone(matrix)
          new_matrix[y][x] = tiles[rotation][tile_nr]

          rm = rec_search(tiles, new_matrix, new_tiles_left)

          return rm if rm
        end
      end
    end
  end

  nil
end

tiles = {
  0 => tiles0,
  1 => tiles1,
  2 => tiles2,
  3 => tiles3,
  4 => tiles4,
  5 => tiles5,
  6 => tiles6,
  7 => tiles7
}

result_matrix = rec_search(tiles, matrix, tiles0.keys)

result = 1

result_matrix.each.with_index do |row, row_i|
  row.each.with_index do |col, col_i|
    tile_nr = nil
    tile_rot = nil

    tiles.each do |rotation, tiles_r|
      tiles_r.each do |number, tile|
        if tile[:top] == col[:top] && tile[:left] == col[:left] && tile[:right] == col[:right] && tile[:bottom] == col[:bottom]
          tile_nr = number
          tile_rot = rotation
          result *= tile_nr if [result_matrix.count - 1, 0].include?(row_i) && [result_matrix.count - 1, 0].include?(col_i)
          break
        end
      end

      break if tile_nr
    end
  end
end

puts result

# problem 2

result_matrix = result_matrix.map { |a| a.map { |b| b[:contents] } }
result_matrix = result_matrix.map { |a| a.map { |b| b[1..-2].map { |c| c[1..-2] } } }

inner_tile_len = result_matrix.first.first.count

joint_matrix_len = matrix_len * inner_tile_len
joint_matrix = Array.new(joint_matrix_len)
joint_matrix = joint_matrix.map { |_| Array.new(joint_matrix_len) }

joint_matrix.each.with_index do |joint_row, y|
  tile_y = y / inner_tile_len
  inner_y = y % inner_tile_len

  joint_row.each.with_index do |_, x|
    tile_x = x / inner_tile_len
    tile = result_matrix[tile_y][tile_x]

    inner_x = x % inner_tile_len
    val = tile[inner_y][inner_x]

    joint_matrix[y][x] = val
  end
end

monster_pattern = [
  '                  # '.chars,
  '#    ##    ##    ###'.chars,
  ' #  #  #  #  #  #   '.chars
]

def match_monster(joint_matrix, y, x, monster_pattern)
  monster_pattern.each.with_index do |monster_row, m_y|
    monster_row.each.with_index do |monster_val, m_x|
      next unless monster_val == '#'

      matrix_val = joint_matrix[y + m_y] ? (joint_matrix[y + m_y][x + m_x] || '.') : '.'
      return false if matrix_val == '.'
    end
  end

  true
end

def paint_monster(joint_matrix, y, x, monster_pattern)
  monster_pattern.each.with_index do |monster_row, m_y|
    monster_row.each.with_index do |monster_val, m_x|
      next unless monster_val == '#'

      joint_matrix[y + m_y][x + m_x] = 'O'
    end
  end
end

(0...8).each do |i|
  joint_matrix.each.with_index do |row, y|
    row.each.with_index do |_, x|
      if match_monster(joint_matrix, y, x, monster_pattern)
        paint_monster(joint_matrix, y, x, monster_pattern)
      end
    end
  end

  if i == 4
    joint_matrix = flip(joint_matrix)
  else
    joint_matrix = rotate(joint_matrix)
  end
end

joint_matrix = flip(rotate(joint_matrix))

result = joint_matrix.map { |a| a.map { |b| b.count('#') }.sum }.sum

puts result
