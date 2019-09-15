class PriorityQueue(T)
  def initialize(capacity : Int32)
    @elem = Array(T).new(capacity)
  end
 
  def initialize(list : Enumerable(T))
    @elem = list.to_a
    1.upto(size - 1) { |i| fixup(i) }
  end
 
  def size
    @elem.size
  end

  def <<(value : T)
    push(value)
  end
 
  def push(v)
    @elem << v
    fixup(size - 1)
  end
 
  def top
    @elem[0]
  end
 
  def pop
    ret = @elem[0]
    last = @elem.pop
    if size > 0
      @elem[0] = last
      fixdown(0)
    end
    ret
  end
 
  def decrease_top(new_value : T)
    @elem[0] = new_value
    fixdown(0)
  end
 
  def to_s(io : IO)
    io << @elem
  end
 
  private def fixup(index : Int32)
    while index > 0
      parent = (index - 1) / 2
      break if @elem[parent] >= @elem[index]
      @elem[parent], @elem[index] = @elem[index], @elem[parent]
      index = parent
    end
  end
 
  private def fixdown(index : Int32)
    while true
      left = index * 2 + 1
      break if left >= size
      right = index * 2 + 2
      child = right >= size || @elem[left] > @elem[right] ? left : right
      if @elem[child] > @elem[index]
        @elem[child], @elem[index] = @elem[index], @elem[child]
        index = child
      else
        break
      end
    end
  end
end


n, m = read_line.split.map(&.to_u64)
ais = read_line.split.map(&.to_u64)

q = PriorityQueue(UInt64).new(n.to_i32)
ais.each {|a| q << a}

m.times do
  m = q.pop.not_nil!
  q << m / 2
end

ret = 0_u64
n.times {ret += q.pop.not_nil!}

puts ret