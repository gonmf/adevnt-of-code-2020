# problem 1

input = File.read('14.input').split("\n")

mask_filter = 0b111111111111111111111111111111111111
mask_replmt = 0b000000000000000000000000000000000000

mem = {}

def parse_mask(mask)
  mask_filter = mask.gsub('1', '0').gsub('X', '1').to_i(2)
  mask_replmt = mask.gsub('X', '0').to_i(2)

  [mask_filter, mask_replmt]
end

input.each do |line|
  if line.start_with?('mask = ')
    mask = line.sub('mask = ', '')

    mask_filter, mask_replmt = parse_mask(mask)
  elsif line.start_with?('mem[')
    mem_pos, value = line.sub('mem[', '').sub('] = ', ' ').split(' ')
    mem_pos = mem_pos.to_i
    value = value.to_i

    mem[mem_pos] = (value & mask_filter) | (mask_replmt & (~mask_filter))
  end
end

puts mem.values.sum

# problem 2

mem = {}

bitmask = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'.chars

def rec_expand_and_set(address, bitmask, idx, mem, value)
  if idx == address.count
    mem[address.join('')] = value
    return
  end

  mask_bit = bitmask[idx]

  if mask_bit == '0'
    rec_expand_and_set(address, bitmask, idx + 1, mem, value)
  elsif mask_bit == '1'
    address[idx] = '1'
    rec_expand_and_set(address, bitmask, idx + 1, mem, value)
  else
    tmp_adr = address.clone
    tmp_adr[idx] = '0'
    rec_expand_and_set(tmp_adr, bitmask, idx + 1, mem, value)
    address[idx] = '1'
    rec_expand_and_set(address, bitmask, idx + 1, mem, value)
  end
end

input.each do |line|
  if line.start_with?('mask = ')
    bitmask = line.sub('mask = ', '').chars
  elsif line.start_with?('mem[')
    mem_pos, value = line.sub('mem[', '').sub('] = ', ' ').split(' ')
    mem_pos = mem_pos.to_i
    value = value.to_i

    rec_expand_and_set(mem_pos.to_s(2).rjust(36, '0').chars, bitmask, 0, mem, value)
  end
end

puts mem.values.sum
