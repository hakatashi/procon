# PriorityQueue.cr by Koki Takahashi
# Licensed under MIT License

class PriorityQueue(T)
  property heap : Array(T)

  def initialize
    initialize(&.itself)
  end

  def initialize(&block : T -> Int64)
    @heap = Array(T).new
    @priority_proc = block
  end

  def push(v : T)
    @heap << v
    index = @heap.size - 1
    while index != 0
      parent = (index - 1) / 2
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

  delegate :empty?, to: @heap
end


x, y, z, k = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort.reverse
bs = read_line.split.map(&.to_i64).sort.reverse
cs = read_line.split.map(&.to_i64).sort.reverse

q = PriorityQueue(Tuple(Int32, Int32, Int32)).new do |(ai, bi, ci)|
  ais[ai] + bs[bi] + cs[ci]
end
set = Set(Tuple(Int32, Int32, Int32)).new

q << {0, 0, 0}
set << {0, 0, 0}

k.times do
  ai, bi, ci = q.pop.not_nil!
  [
    {ai + 1, bi, ci},
    {ai, bi + 1, ci},
    {ai, bi, ci + 1},
  ].each do |t|
    if t[0] < ais.size && t[1] < bs.size && t[2] < cs.size && !set.includes?(t)
      set << t
      q << t
    end
  end
  puts ais[ai] + bs[bi] + cs[ci]
end