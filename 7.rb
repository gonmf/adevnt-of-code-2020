# problem 1

input = File.read('7.input')

def parse_contents(vals)
  number, n0, n1, n2, *remainder = vals

  bag_name = "#{n0} #{n1}"

  remainder.any? ? [[number.to_i, bag_name]] + parse_contents(remainder) : [[number.to_i, bag_name]]
end

def parse_line(line)
  n0, n1, n2, contains, *remainder = line.split(' ')

  bag_name = "#{n0} #{n1}"

  if line.include?('contain no other bags.')
    [bag_name, []]
  else
    [bag_name, parse_contents(remainder)]
  end
end

rules = []

input.split("\n").each do |line|
  bag_rule = parse_line(line)

  rules.push(bag_rule)
end

simplified_rules = {}

rules.each do |rule|
  contents = rule[1]
  next if contents.nil?

  contents = contents.map do |content|
    content[1]
  end

  simplified_rules[rule[0]] = contents
end

def contains_bag(simplified_rules, bag_name, goal)
  return true if bag_name == goal

  contains = simplified_rules[bag_name]
  if contains.nil?
    puts "#{bag_name} not contained"
  end

  contains.any? { |name| contains_bag(simplified_rules, name, goal) }
end

co =  simplified_rules.keys.select do |bag_name|
  bag_name != 'shiny gold' && contains_bag(simplified_rules, bag_name, 'shiny gold')
end

puts co.count

# problem 2

def count_bags(rules, bag_name)
  rule = rules.select { |r| r[0] == bag_name }.first
  return 1 if rule[1].nil?

  return 1 + rule[1].map { |r| r[0] * count_bags(rules, r[1]) }.sum
end

puts count_bags(rules, 'shiny gold') - 1
