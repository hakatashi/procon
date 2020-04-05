# PriorityQueue.cr by Koki Takahashi
# Licensed under MIT License

class PriorityQueue(T)
  property heap : Array(T)

  def initialize
    @heap = Array(T).new
  end

  def push(v : T)
    @heap << v
    index = @heap.size - 1
    while index != 0
      parent = (index - 1) // 2
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



n, m = read_line.split.map(&.to_u64)
ais = read_line.split.map(&.to_u64)

q = PriorityQueue(UInt64).new
ais.each {|a| q << a}

m.times do
  m = q.pop.not_nil!
  q << m // 2
end

ret = 0_u64
n.times {ret += q.pop.not_nil!}

puts ret