# problem 1

input = File.read('06.input')

acc = ''
sum = 0

input.split("\n").each do |line|
  if line == ''
    if acc != ''
      sum += acc.chars.uniq.count
      acc = ''
    end
  else
    acc += line.strip
  end
end

if acc != ''
  sum += acc.chars.uniq.count
end

puts sum

# problem 2

def all_present(text)
  texts = text.split('|').map(&:chars)

  texts.reduce(texts[0]) { |acc, text| acc & text }.count
end

acc = nil
sum = 0

input.split("\n").each do |line|
  if line == ''
    if acc
      sum += all_present(acc)
      acc = nil
    end
  else
    acc = acc ? "#{acc}|#{line.strip}" : line.strip
  end
end

if acc
  sum += all_present(acc)
end

puts sum
