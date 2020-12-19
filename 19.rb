# problem 1

require 'set'

input = File.read('19.input').split("\n")

def mux_root(part1, part2, target_messages)
  ret = []
  target_messages = Set.new(target_messages)

  part1.each do |s1|
    part2.each do |s2|
      s = "#{s1}#{s2}"

      ret.push(s) if target_messages.include?(s)
    end
  end

  ret
end

def mux(part1, part2, target_messages)
  ret = []

  part1.each do |s1|
    part2.each do |s2|
      s = "#{s1}#{s2}"

      ret.push(s) if target_messages.any? { |m| m.include?(s) }
    end
  end

  ret
end

def rec_expand_rule(rules, i, target_messages, memo, root_i)
  memo[i] ||= begin
    bodies = rules[i]

    ret = []

    bodies.each do |body|
      if body.is_a?(String)
        ret.push(body)
      else
        combs = nil

        body.each.with_index do |i, idx|
          res = rec_expand_rule(rules, i, target_messages, memo, root_i)

          if idx == 0
            combs = res
          else
            if i == root_i
              combs = mux_root(combs, res, target_messages)
            else
              combs = mux(combs, res, target_messages)
            end
          end

          break unless combs.any?
        end

        ret = ret + combs
      end
    end

    ret.uniq
  end
end

def expand_rule(rules, rule_nr, target_messages)
  rec_expand_rule(rules, rule_nr, target_messages, {}, rule_nr)
end

rules = {}
min_len = {}
messages = []

i = 0

while true
  number, body = input[i]&.split(': ')
  break if body.nil?

  bodies = body.split(' | ')

  bodies = bodies.map do |b|
    b.include?('"') ? b.gsub('"', '') : b.split(' ').map(&:to_i)
  end

  rules[number.to_i] = bodies

  i += 1
end

while i < input.count
  message = input[i]
  if message.nil? || message.size == 0
    i += 1
    next
  end

  messages.push(message)

  i += 1
end

message = messages.uniq.sort

result = expand_rule(rules, 0, messages)

puts (messages & result).count

# problem 2

rules[8] = [
  [42],
  [42, 42],
  [42, 42, 42],
  [42, 42, 42, 42],
  [42, 42, 42, 42, 42],
  [42, 42, 42, 42, 42, 42],
  [42, 42, 42, 42, 42, 42, 42],
  [42, 42, 42, 42, 42, 42, 42, 42],
  [42, 42, 42, 42, 42, 42, 42, 42, 42]
]


rules[11] = [
  [42, 31],
  [42, 42, 31, 31],
  [42, 42, 42, 31, 31, 31],
  [42, 42, 42, 42, 31, 31, 31, 31],
  [42, 42, 42, 42, 42, 31, 31, 31, 31, 31]
]

result = expand_rule(rules, 0, messages)

puts (messages & result).count
