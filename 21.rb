# problem 1

input = File.read('21.input').split("\n")

all_foods = []
all_alergens = []
alergens_table = {}

input.each do |line|
  foods, alergens = line.split(' (contains ')

  foods = foods.split(' ')
  alergens = alergens.sub(')', '').split(', ')

  all_foods = (all_foods + foods).uniq
  all_alergens = (all_alergens + alergens).uniq

  alergens.each do |alergen|
    if alergens_table[alergen]
      alergens_table[alergen] = alergens_table[alergen] & foods
    else
      alergens_table[alergen] = foods
    end
  end
end

safe_foods = all_foods - alergens_table.values.flatten.uniq

count = 0

input.each do |line|
  foods, alergens = line.split(' (contains ')

  foods = foods.split(' ')

  count += (foods & safe_foods).count
end

puts count

# problem 2

repeat = true

while repeat
  repeat = false

  alergens_table.each do |k, v|
    if v.count == 1
      alergens_table.each do |k2, v2|
        if k != k2 && v2.include?(v[0])
          new_v = v2 - [v[0]]
          alergens_table[k2] = new_v
          repeat = true
        end
      end

      break if repeat
    end
  end
end

puts alergens_table.sort.map { |a| a[1][0] }.join(',')
