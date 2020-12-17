# problem 1

input = File.read('17.input').split("\n")

def space_get(space, x, y, z)
  space[x] ||= {}
  space[x][y] ||= {}
  space[x][y][z] || '.'
end

def space_set(space, x, y, z, value)
  space[x] ||= {}
  space[x][y] ||= {}
  space[x][y][z] = value
end

def space_used(space)
  xs = []
  ys = []
  zs = []

  space.each do |x, yv|
    xs.push(x)

    yv.each do |y, zv|
      ys.push(y)

      zs += zv.keys
    end
  end

  min_x, max_x = xs.minmax
  min_y, max_y = ys.minmax
  min_z, max_z = zs.minmax

  [min_x, max_x, min_y, max_y, min_z, max_z]
end

def count_neighbors(space, x, y, z)
  count = 0

  ((x - 1)..(x + 1)).each do |xl|
    ((y - 1)..(y + 1)).each do |yl|
      ((z - 1)..(z + 1)).each do |zl|
        next if x == xl && y == yl && z == zl

        count += 1 if space_get(space, xl, yl, zl) == '#'
      end
    end
  end

  count
end

def mutate_space(space)
  new_space = {}

  min_x, max_x, min_y, max_y, min_z, max_z = space_used(space)

  min_x -= 1
  max_x += 1
  min_y -= 1
  max_y += 1
  min_z -= 1
  max_z += 1

  (min_x..max_x).each do |x|
    (min_y..max_y).each do |y|
      (min_z..max_z).each do |z|
        neighbors = count_neighbors(space, x, y, z)

        if space_get(space, x, y, z) == '#'
          if neighbors == 2 || neighbors == 3
            space_set(new_space, x, y, z, '#')
          end
        else
          if neighbors == 3
            space_set(new_space, x, y, z, '#')
          end
        end
      end
    end
  end

  new_space
end

def count_active_cubes(space)
  count = 0

  space.each do |x, yv|
    yv.each do |y, zv|
      zv.each do |_, v|
        count += 1 if v == '#'
      end
    end
  end

  count
end

space = {}

input.each.with_index do |line, row|
  line.chars.each.with_index do |value, col|
    space_set(space, col, row, 0, value)
  end
end

cycle = 0

while cycle < 6
  space = mutate_space(space)

  cycle += 1
end

puts count_active_cubes(space)

# problem 2

def space_get(space, x, y, z, w)
  space[x] ||= {}
  space[x][y] ||= {}
  space[x][y][z] ||= {}
  space[x][y][z][w] || '.'
end

def space_set(space, x, y, z, w, value)
  space[x] ||= {}
  space[x][y] ||= {}
  space[x][y][z] ||= {}
  space[x][y][z][w] = value
end

def space_used(space)
  xs = []
  ys = []
  zs = []
  ws = []

  space.each do |x, yv|
    xs.push(x)

    yv.each do |y, zv|
      ys.push(y)

      zv.each do |z, wv|
        zs.push(z)

        ws += wv.keys
      end
    end
  end

  min_x, max_x = xs.minmax
  min_y, max_y = ys.minmax
  min_z, max_z = zs.minmax
  min_w, max_w = ws.minmax

  [min_x, max_x, min_y, max_y, min_z, max_z, min_w, max_w]
end

def count_neighbors(space, x, y, z, w)
  count = 0

  ((x - 1)..(x + 1)).each do |xl|
    ((y - 1)..(y + 1)).each do |yl|
      ((z - 1)..(z + 1)).each do |zl|
        ((w - 1)..(w + 1)).each do |wl|
          next if x == xl && y == yl && z == zl && w == wl

          count += 1 if space_get(space, xl, yl, zl, wl) == '#'
        end
      end
    end
  end

  count
end

def mutate_space(space)
  new_space = {}

  min_x, max_x, min_y, max_y, min_z, max_z, min_w, max_w = space_used(space)

  min_x -= 1
  max_x += 1
  min_y -= 1
  max_y += 1
  min_z -= 1
  max_z += 1
  min_w -= 1
  max_w += 1

  (min_x..max_x).each do |x|
    (min_y..max_y).each do |y|
      (min_z..max_z).each do |z|
        (min_w..max_w).each do |w|
          neighbors = count_neighbors(space, x, y, z, w)

          if space_get(space, x, y, z, w) == '#'
            if neighbors == 2 || neighbors == 3
              space_set(new_space, x, y, z, w, '#')
            end
          else
            if neighbors == 3
              space_set(new_space, x, y, z, w, '#')
            end
          end
        end
      end
    end
  end

  new_space
end

def count_active_cubes(space)
  count = 0

  space.each do |x, yv|
    yv.each do |y, zv|
      zv.each do |z, wv|
        wv.each do |_, v|
          count += 1 if v == '#'
        end
      end
    end
  end

  count
end

space = {}

input.each.with_index do |line, row|
  line.chars.each.with_index do |value, col|
    space_set(space, col, row, 0, 0, value)
  end
end

cycle = 0

while cycle < 6
  space = mutate_space(space)

  cycle += 1
end

puts count_active_cubes(space)

