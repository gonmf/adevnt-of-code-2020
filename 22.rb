# problem 1

require 'set'

input = File.read('22.input').split("\n")

deck1 = []
deck2 = []

ap = 1
input.each do |line|
  if line == 'Player 2:'
    ap = 2
  elsif line != 'Player 1:' && line != ''
    player = ap == 1 ? deck1 : deck2

    player.push(line.to_i)
  end
end

def play_combat(deck1, deck2)
  while deck1.any? && deck2.any?
    if deck1[0] > deck2[0]
      deck1 += [deck1[0], deck2[0]]
    else
      deck2 += [deck2[0], deck1[0]]
    end

    deck1 = deck1[1..-1]
    deck2 = deck2[1..-1]
  end

  deck1.any? ? deck1 : deck2
end

result = 0

winner = play_combat(deck1, deck2)

winner.each.with_index do |val, idx|
  result += val * (winner.count - idx)
end

puts result

# problem 2

def play_rec_combat(deck1, deck2, indent = 0)
  previous_configs = Set.new

  while true
    this_config = "#{deck1.join(',')}|#{deck2.join(',')}"
    if previous_configs.include?(this_config)
      return [1, deck1]
    end

    previous_configs.add(this_config)

    if deck1[0] < deck1.count && deck2[0] < deck2.count
      winner, _ = play_rec_combat(deck1[1..-1][0...deck1[0]], deck2[1..-1][0...deck2[0]], indent + 1)
    else
      winner = deck1[0] > deck2[0] ? 1 : 2
    end

    if winner == 1
      deck1 += [deck1[0], deck2[0]]
    else
      deck2 += [deck2[0], deck1[0]]
    end

    deck1 = deck1[1..-1]
    deck2 = deck2[1..-1]

    return [2, deck2] unless deck1.any?
    return [1, deck1] unless deck2.any?
  end
end

_, winner_deck = play_rec_combat(deck1, deck2)

result = 0

winner_deck.each.with_index do |val, idx|
  result += val * (winner_deck.count - idx)
end

puts result
