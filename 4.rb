# problem 1

input = File.read('4.input')

passport = ''
valid_passports = 0

def valid_passport?(text)
  fields = text.split(' ').select { |part| part.size > 0 }

  pp = {}
  fields.each do |field|
    name, value = field.split(':')

    pp[name] = value
  end

  %w[byr iyr eyr hgt hcl ecl pid].all? { |name| pp[name] && pp[name].size > 0 }
end

input.split("\n").each do |line|
  if line == ''
    next if passport == ''

    valid_passports += 1 if valid_passport?(passport)

    passport = ''
  else
    passport += " #{line.strip}"
  end
end

if passport != ''
  valid_passports += 1 if valid_passport?(passport)
end

puts valid_passports

# problem 2

passport = ''
valid_passports = 0

HEX = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f]
DECIMAL = %w[0 1 2 3 4 5 6 7 8 9]

def valid_hgt?(val)
  if val.end_with?('cm')
    val = val[0..-2]

    val.to_i >= 150 && val.to_i <= 193
  elsif val.end_with?('in')
    val = val[0..-2]

    val.to_i >= 59 && val.to_i <= 76
  end
end

def valid_hcl?(val)
  val.size == 7 && val[0] == '#' && val[1..-1].chars.all? { |c| HEX.include?(c) }
end

def valid_pid?(val)
  val.size == 9 && val.chars.all? { |c| DECIMAL.include?(c) }
end

def valid_passport?(text)
  fields = text.split(' ').select { |part| part.size > 0 }

  pp = {}
  fields.each do |field|
    name, value = field.split(':')

    pp[name] = value
  end

  return unless %w[byr iyr eyr hgt hcl ecl pid].all? { |name| pp[name] && pp[name].size > 0 }

  return unless pp['byr'].size == 4 && pp['byr'].to_i >= 1920 && pp['byr'].to_i <= 2002
  return unless pp['iyr'].size == 4 && pp['iyr'].to_i >= 2010 && pp['iyr'].to_i <= 2020
  return unless pp['eyr'].size == 4 && pp['eyr'].to_i >= 2020 && pp['eyr'].to_i <= 2030
  return unless valid_hgt?(pp['hgt'])
  return unless valid_hcl?(pp['hcl'])
  return unless %w[amb blu brn gry grn hzl oth].include?(pp['ecl'])
  valid_pid?(pp['pid'])
end

input.split("\n").each do |line|
  if line == ''
    next if passport == ''

    valid_passports += 1 if valid_passport?(passport)

    passport = ''
  else
    passport += " #{line.strip}"
  end
end

if passport != ''
  valid_passports += 1 if valid_passport?(passport)
end

puts valid_passports
