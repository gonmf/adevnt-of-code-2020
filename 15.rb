# problem 1

input = File.read('15.input').strip.split(',')

def solve(input, goal_turn)
  numbers_spoken = {}
  last_spoken = nil
  new_number = true
  turn = 0

  input.each do |starting_number|
    starting_number = starting_number.to_i
    turn += 1

    numbers_spoken[starting_number] ||= []
    numbers_spoken[starting_number].push(turn)
    last_spoken = starting_number
  end

  while turn < goal_turn
    turn += 1

    if new_number
      last_spoken = 0
    else
      penultime_spoken, last_spoken = numbers_spoken[last_spoken]
      last_spoken -= penultime_spoken
    end

    new_number = numbers_spoken[last_spoken].nil?
    if numbers_spoken[last_spoken]
      numbers_spoken[last_spoken] = [numbers_spoken[last_spoken].last, turn]
    else
      numbers_spoken[last_spoken] = [turn]
    end
  end

  last_spoken
end

puts solve(input, 2020)

# problem 2

puts solve(input, 30000000)


