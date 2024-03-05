class LinkedList
  def initialize
    @head = nil
  end

  def head
    @head.nil? ? nil : @head
  end

  def tail(node = @head)
    return node if node.next.nil?

    tail(node.next)
  end

  def append(value)
    return @head = Node.new(value) if @head.nil?

    tail.next = Node.new(value)
  end

  def prepend(value)
    return @head = Node.new(value) if @head.nil?

    curr_node = Node.new(value)
    curr_node.next = @head
    @head = curr_node
  end

  def size(count = 1, node = @head)
    return 0 if node.nil?
    return count if node.next.nil?

    size(count + 1, node.next)
  end

  def at(index, count = 0, node = @head)
    return nil if node.nil?
    return nil if count >= size
    return node if count == index

    at(index, count + 1, node.next)
  end

  def pop
    last_node = tail
    prev_node = at(size - 2)

    prev_node.next = nil
    last_node
  end

  def contains?(value, node = @head)
    return true if node.value == value
    return false if node.next.nil?

    contains?(value, node.next)
  end

  def find(value, count = 0, node = @head)
    return count if node.value == value
    return nil if node.next.nil?

    find(value, count + 1, node.next)
  end

  def insert_at(value, index)
    new_node = Node.new(value)
    if index == 0
      node = @head
      @head = new_node
      return @head.next = node
    end
    node = at(index)

    next_node = node.next
    node.next = new_node
    new_node.next = next_node
  end

  def remove_at(index)
    if index == 0
      node = @head
      @head = node.next
      return node
    end

    node = at(index - 1)

    curr_node = node.next
    next_node = curr_node.next
    prev_node = node
    prev_node.next = next_node
    curr_node
  end

  def to_s
    curr_node = @head
    print_list = ''
    loop do
      return print_list += 'nil' if curr_node.nil?

      print_list += "(#{curr_node.value}) -> "
      curr_node = curr_node.next
    end
    print_list
  end
end

class Node
  attr_accessor :next
  attr_reader   :value

  def initialize(value)
    @value = value
    @next  = nil
  end

  def to_s
    "#{value}"
  end
end

linked = LinkedList.new

linked.append(1)
linked.append(2)
linked.append(3)
linked.append(4)
linked.append(9)
linked.append(5)
puts linked.tail
linked.append(6)
puts linked.at(4)
puts linked.contains?(0)
linked.insert_at(7, 6)
linked.remove_at(4)
puts "pop : #{linked.pop}"
puts linked
# puts linked.pop