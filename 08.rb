# problem 1

input = File.read('08.input').split("\n")

position = 0
accumulator = 0

visited_already = []

def interpret(instruction, curr_pos, curr_accumulator)
  name, value = instruction.split(' ')

  if name == 'nop'
    [curr_pos + 1, curr_accumulator]
  elsif name == 'acc'
    [curr_pos + 1, curr_accumulator + value.to_i]
  elsif name == 'jmp'
    [curr_pos + value.to_i, curr_accumulator]
  else
    puts 'ERROR'
  end
end

while true
  break if visited_already.include?(position)

  visited_already.push(position)

  instruction = input[position]

  position, accumulator = interpret(instruction, position, accumulator)
end

puts accumulator

# problem 2

input.each do |line|
  next if line.include?('acc')

  line.include?('jmp') ? line.sub!('jmp', 'nop') : line.sub!('nop', 'jmp')

  position = 0
  accumulator = 0

  visited_already = []

  target_position = input.count

  while true
    if position == target_position
      result = true
      break
    elsif position > target_position
      result = false
      break
    end

    if visited_already.include?(position)
      result = false
      break
    end

    visited_already.push(position)

    instruction = input[position]

    position, accumulator = interpret(instruction, position, accumulator)
  end

  line.include?('jmp') ? line.sub!('jmp', 'nop') : line.sub!('nop', 'jmp')

  puts accumulator if result
end
