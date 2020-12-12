# problem 1

input = File.read('12.input').split("\n")

x = 0
y = 0
dir_x = 1
dir_y = 0

def rotate_90(dir_x, dir_y)
  [-dir_y, dir_x]
end

def rotate(degrees, dir_x, dir_y)
  while degrees < 0
    degrees += 360
  end

  (0...(degrees / 90)).each do
    dir_x, dir_y = rotate_90(dir_x, dir_y)
  end

  [dir_x, dir_y]
end

def interpret(instruction, x, y, dir_x, dir_y)
  command = instruction[0]
  number = instruction[1..-1].to_i

  if command == 'F'
    x += dir_x * number
    y += dir_y * number
  elsif command == 'N'
    y += number
  elsif command == 'S'
    y -= number
  elsif command == 'E'
    x += number
  elsif command == 'W'
    x -= number
  elsif command == 'L'
    dir_x, dir_y = rotate(number, dir_x, dir_y)
  elsif command == 'R'
    dir_x, dir_y = rotate(-number, dir_x, dir_y)
  end

  [x, y, dir_x, dir_y]
end

input.each do |instruction|
  x, y, dir_x, dir_y = interpret(instruction, x, y, dir_x, dir_y)
end

puts x.abs + y.abs

# problem 2

x = 0
y = 0
wp_x = 10
wp_y = 1

def interpret(instruction, x, y, wp_x, wp_y)
  command = instruction[0]
  number = instruction[1..-1].to_i

  if command == 'N'
    wp_y += number
  elsif command == 'S'
    wp_y -= number
  elsif command == 'E'
    wp_x += number
  elsif command == 'W'
    wp_x -= number
  elsif command == 'L'
    wp_x, wp_y = rotate(number, wp_x, wp_y)
  elsif command == 'R'
    wp_x, wp_y = rotate(-number, wp_x, wp_y)
  elsif command == 'F'
    x += wp_x * number
    y += wp_y * number
  end

  [x, y, wp_x, wp_y]
end

input.each do |instruction|
  x, y, wp_x, wp_y = interpret(instruction, x, y, wp_x, wp_y)
end

puts x.abs + y.abs
