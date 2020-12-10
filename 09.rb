# problem 1

input = File.read('09.input').split("\n").map(&:to_i)

preamble_size = 25

def is_sum?(list, number)
  list.each.with_index do |v1, idx1|
    list.each.with_index do |v2, idx2|
      next if idx1 == idx2

      return true if v1 + v2 == number
    end
  end

  false
end

result = nil

input.each.with_index do |number, idx|
  next if idx < preamble_size

  last = input[(idx - preamble_size)...idx]

  if !is_sum?(last, number)
    result = number
    break
  end
end

puts result

# problem 2

goal = result

input.each.with_index do |number1, idx1|
  sum = number1

  input.each.with_index do |number2, idx2|
    next if idx2 <= idx1

    sum += number2

    break if sum > goal

    if sum == goal
      puts input[idx1..idx2].minmax.sum
      return
    end
  end
end

