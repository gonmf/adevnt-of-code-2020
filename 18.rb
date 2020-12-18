# problem 1

input = File.read('18.input').split("\n")

def tokenizer(line)
  tokens = []

  s = ''

  line.chars.each do |c|
    if %w[1 2 3 4 5 6 7 8 9 0].include?(c)
      s += c
    elsif c != ' '
      if s.size > 0
        tokens.push(s)
        s = ''
      end

      tokens.push(c)
    end
  end

  if s.size > 0
    tokens.push(s)
  end

  tokens
end

def rec_interpret(tokens, start)
  val = nil
  oper = nil
  i = start

  while i < tokens.count
    token = tokens[i]

    if token.nil?
      i += 1
      next
    elsif token == '('
      new_val = rec_interpret(tokens, i + 1)

      tokens[i] = new_val
      next
    elsif token == ')'
      (start..i).each do |j|
        tokens[j] = nil
      end

      return val
    elsif %w[+ - * /].include?(token)
      oper = token
    else
      if oper
        val = val.to_i.send(oper, token.to_i)
        oper = nil
      else
        val = token
      end
    end

    i += 1
  end

  val
end

def interpret(line)
  tokens = tokenizer(line)

  rec_interpret(tokens, 0)
end

sum = 0

input.each.with_index do |line, idx|
  result = interpret(line)

  sum += result
end

puts sum

# problem 2

def hierarchize(tokens, start)
  ret = []
  i = start

  while i < tokens.count
    token = tokens[i]

    if token == '('
      token, i = hierarchize(tokens, i + 1)
      ret.push(token)
      next
    elsif token == ')'
      return [ret, i + 1]
    else
      ret.push(token)
    end

    i += 1
  end

  [ret, i]
end

def parenthize(tokens)
  i = 0

  while i < tokens.count
    token = tokens[i]

    if token.is_a?(Array)
      tokens[i] = parenthize(token)
    elsif token == '+'
      prev_token = tokens[i - 1]
      next_token = tokens[i + 1]
      tokens[i - 1] = [prev_token, token, next_token.is_a?(Array) ? parenthize(next_token) : next_token]
      tokens[i] = nil
      tokens[i + 1] = nil
      tokens = tokens.compact
      next
    end

    i += 1
  end

  tokens
end

def flatten_hierarchy(tokens)
  tokens.map do |token|
    if token.is_a?(Array)
      ['('] + flatten_hierarchy(token) + [')']
    else
      token
    end
  end.flatten
end

def interpret2(line)
  tokens = tokenizer(line)

  tokens, _ = hierarchize(tokens, 0)

  tokens = parenthize(tokens)

  tokens = flatten_hierarchy(tokens)

  rec_interpret(tokens, 0)
end

sum = 0

input.each.with_index do |line, idx|
  result = interpret2(line)

  sum += result
end

puts sum
