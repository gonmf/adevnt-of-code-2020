# problem 1

input = File.read('10.input').split("\n").map(&:to_i)

jolts = 0
diff_1 = 0
diff_3 = 1

while true
  new_jolts = input.select { |v| [jolts + 1, jolts + 2, jolts + 3].include?(v) }.min
  break unless new_jolts

  diff_1 += 1 if jolts + 1 == new_jolts
  diff_3 += 1 if jolts + 3 == new_jolts

  jolts = new_jolts
end

puts diff_1 * diff_3

# problem 2

memo = {}

input.push(0)

def count_combs(goal, input, memo)
  memo[goal] ||= begin
    return 1 if goal == 0

    new_goals = input.select { |v| [goal - 1, goal - 2, goal - 3].include?(v) }

    new_goals.map do |new_goal|
      count_combs(new_goal, input, memo)
    end.sum
  end
end

puts count_combs(input.max + 3, input, memo)

# problem 2 alternative solution

memo = {}

input.push(input.max + 3)

def count_combs2(curr, goal, input, memo)
  memo[curr] ||= begin
    return 1 if curr == goal

    new_currs = input.select { |v| [curr + 1, curr + 2, curr + 3].include?(v) }

    new_currs.map do |c|
      count_combs2(c, goal, input, memo)
    end.sum
  end
end

puts count_combs2(0, input.max, input, memo)
