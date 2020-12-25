card_public_key, door_public_key, _ = File.read('25.input').split("\n")
card_public_key = card_public_key.to_i
door_public_key = door_public_key.to_i

def transform(subject, loop_size)
  loop_i = 0

  value = 1
  while loop_i < loop_size
    loop_i += 1

    value = (value * subject) % 20201227
  end

  value
end

i = 1
card_i = nil
door_i = nil
public_key = 1
while card_i.nil? || door_i.nil?
  public_key = (public_key * 7) % 20201227

  card_i = i if card_public_key == public_key
  door_i = i if door_public_key == public_key

  i += 1
end

encryption_key = door_i < card_i ? transform(card_public_key, door_i) : transform(door_public_key, card_i)

puts encryption_key
