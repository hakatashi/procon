# PriorityQueue.cr by Koki Takahashi
# Licensed under MIT License

class PriorityQueue(T)
  property heap : Array(T)

  def initialize(n : Int32)
    @heap = Array(T).new(n)
  end

  def push(v : T)
    @heap << v
    index = @heap.size - 1
    while index != 0
      parent = (index - 1) / 2
      if @heap[parent] >= @heap[index]
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
      child = if index * 2 + 2 < @heap.size && @heap[index * 2 + 1] < @heap[index * 2 + 2]
        index * 2 + 2
      else
        index * 2 + 1
      end
      if @heap[index] >= @heap[child]
        break
      end
      @heap[child], @heap[index] = @heap[index], @heap[child]
      index = child
    end
    ret
  end

  delegate :empty?, to: @heap
end



n, m = read_line.split.map(&.to_i)
q = PriorityQueue(UInt32).new(n)
js = STDIN.gets_to_end.lines.map do |line|
  a, b = line.split.map(&.to_u32)
  {a, b}
end
js.sort!
ret = 0_u64
m.times do |i|
  while js.size != 0 && js[0][0] <= i + 1
    j = js.shift
    q << j[1]
  end
  value = q.pop
  unless value.nil?
    ret += value
  end
end
puts ret