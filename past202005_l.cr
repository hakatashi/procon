# -*- contest: past202005-open -*-

# PriorityQueue.cr by Koki Takahashi
# Licensed under MIT License https://mit-license.org

class PriorityQueue(T)
  property heap : Array(T)

  def initialize
    initialize(&.itself)
  end

  def initialize(&block : T -> (Int8 | Int16 | Int32 | Int64 | UInt8 | UInt16 | UInt32 | UInt64))
    @heap = Array(T).new
    @priority_proc = block
  end

  def push(v : T)
    @heap << v
    index = @heap.size - 1
    while index != 0
      parent = (index - 1) // 2
      if @priority_proc.call(@heap[parent]) >= @priority_proc.call(@heap[index])
        break
      end
      @heap[parent], @heap[index] = @heap[index], @heap[parent]
      index = parent
    end
  end

  def <<(v : T)
    push(v)
  end

  def pop
    if @heap.size == 0
      return nil
    end
    if @heap.size == 1
      return @heap.pop
    end
    ret = @heap.first
    @heap[0] = @heap.pop
    index = 0
    while index * 2 + 1 < @heap.size
      child = if index * 2 + 2 < @heap.size && @priority_proc.call(@heap[index * 2 + 1]) < @priority_proc.call(@heap[index * 2 + 2])
        index * 2 + 2
      else
        index * 2 + 1
      end
      if @priority_proc.call(@heap[index]) >= @priority_proc.call(@heap[child])
        break
      end
      @heap[child], @heap[index] = @heap[index], @heap[child]
      index = child
    end
    ret
  end

  def top
    if @heap.size == 0
      return nil
    end
    @heap.first
  end

  delegate :empty?, to: @heap
end


n = read_line.to_i64
arrays = [] of Deque(Int64)
n.times do
  tokens = read_line.split.map(&.to_i64)
  arrays << Deque(Int64).new(tokens[1..])
end
m = read_line.to_i64
ais = read_line.split.map(&.to_i64)

items = Hash(Int64, Int64).new
arrays.each_with_index do |array, i|
  array.each do |item|
    items[item] = i.to_i64
  end
end

queue1 = PriorityQueue(Int64).new
queue2 = PriorityQueue(Int64).new

arrays.each do |array|
  item = array.shift
  queue1 << item
  queue2 << item
  unless array.empty?
    item = array.first
    queue2 << item
  end
end

taken = Set(Int64).new

ais.each do |a|
  if a == 1
    item = -1_i64
    until item != -1 && !taken.includes?(item)
      item = queue1.pop.not_nil!
    end
    taken << item
    pos = items[item]
    unless arrays[pos].empty?
      queue1 << arrays[pos].shift
    end
    unless arrays[pos].empty?
      queue2 << arrays[pos].first
    end
    p item
  else
    item = -1_i64
    until item != -1 && !taken.includes?(item)
      item = queue2.pop.not_nil!
    end
    taken << item
    pos = items[item]
    if !arrays[pos].empty? && arrays[pos].first == item
      arrays[pos].shift
      unless arrays[pos].empty?
        queue2 << arrays[pos].first
      end
    else
      unless arrays[pos].empty?
        queue1 << arrays[pos].shift
      end
      unless arrays[pos].empty?
        queue2 << arrays[pos].first
      end
    end
    p item
  end
end

