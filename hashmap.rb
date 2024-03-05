class HashMap 
  def initialize
    @buckets = Array.new(16)
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    resize if load_factor > 0.75

    index = hash(key) % @buckets.length
    valid_index?(index)
    
    @buckets[index] = [] if @buckets[index].nil?
    is_exist = @buckets[index].find { |item| item[0] == key }

    is_exist ? is_exist[1] = value : @buckets[index] << [key, value]
  end

  def get(key)
    index = hash(key) % @buckets.length
    valid_index?(index) 

    item = @buckets[index].find { |item| item[0] == key }[1]
  end

  def has(key)
    !get(key).nil?
  end

  def remove(key)
    index = hash(key) % @buckets.length
    valid_index?(index) 

    item_index = @buckets[index].find_index { |item| item[0] == key}
    @buckets.delete_at(item_index)
  end

  def clear
    @buckets = Array.new(16)
  end

  def keys
    @buckets.compact.flatten(1).map { |item| item[0] }
  end

  def values
    @buckets.compact.flatten(1).map { |item| item[1] }
  end

  def entries
    @buckets.compact.flatten(1)
  end

  def length
    @buckets.compact.sum { |item| item.size }
  end

  protected
  def load_factor
    length.to_f / @buckets.length
  end

  def resize
    old_buckets = @buckets
    @buckets = Array.new(@buckets.length * 2)

    old_buckets.compact.flatten(1).each { |key, value| set(key, value) }
  end

  def valid_index?(index)
    raise IndexError if index.negative? || index >= @buckets.length
  end
end


hash = HashMap.new

puts hash.set("Himumi", 10)
puts hash.set("Himumi", 9)
puts hash.get("Himumi")

puts hash.has("Himumi")
puts hash.keys
puts hash.values
p hash.entries
p hash.length
