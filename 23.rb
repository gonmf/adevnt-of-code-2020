# problem 1

input = '789465123'

class ListNode
  def initialize(value, prev_node = nil, next_node = nil)
    @value = value
    @prev_node = prev_node
    @next_node = next_node
  end

  def self.from_array(a)
    root = nil
    curr = nil

    a.each do |e|
      if root.nil?
        root = ListNode.new(e)
        curr = root
        root.prev_node = root
        root.next_node = root
      else
        prev = curr
        curr = ListNode.new(e, prev, root)
        root.prev_node = curr
        prev.next_node = curr
      end
    end

    root
  end

  def self.as_array(node)
    a = [node.value]
    n = node.next_node

    while n != node
      a.push(n.value)
      n = n.next_node
    end

    a
  end

  attr_accessor :value, :prev_node, :next_node
end

def play_crab(cups, moves)
  min_cup = cups.min
  max_cup = cups.max

  current_cup = ListNode.from_array(cups)
  cups_by_number = { current_cup.value => current_cup }

  cc = current_cup.next_node
  while cc != current_cup
    cups_by_number[cc.value] = cc

    cc = cc.next_node
  end

  while moves > 0
    three_cups_start = current_cup.next_node
    three_cups_end = three_cups_start.next_node.next_node

    current_cup.next_node = three_cups_end.next_node
    current_cup.next_node.prev_node = current_cup

    three_cups_start.prev_node = three_cups_end
    three_cups_end.next_node = three_cups_start

    three_cups_values = [three_cups_start.value, three_cups_start.next_node.value, three_cups_end.value]

    destination_cup_value = current_cup.value
    while true
      destination_cup_value -= 1

      if destination_cup_value < min_cup
        destination_cup_value = max_cup
      end

      break unless three_cups_values.include?(destination_cup_value)
    end

    destination_cup = cups_by_number[destination_cup_value]

    destination_cup.next_node.prev_node = three_cups_end
    three_cups_end.next_node = destination_cup.next_node

    destination_cup.next_node = three_cups_start
    three_cups_start.prev_node = destination_cup

    current_cup = current_cup.next_node

    moves -= 1
  end

  cups_by_number[1].next_node
end

cups = input.chars.map(&:to_i)

result = play_crab(cups, 100)

puts (ListNode.as_array(result) - [1]).join

# problem 2

new_cups = Array.new(1_000_000)
new_cups.each.with_index do |_, idx|
  new_cups[idx] = cups[idx] || (idx + 1)
end

result = play_crab(new_cups, 10_000_000)

puts result.value * result.next_node.value
