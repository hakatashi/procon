# PriorityQueue.cr by Koki Takahashi
# Licensed under MIT License

# Skew heap
class Heap(T)
  property left : Heap(T)?, right : Heap(T)?, value : T?

  def initialize(v : T?)
    @value = v
    @left = nil
    @right = nil
  end

  def self.meld(a : Heap(T)?, b : Heap(T)?)
    return Heap(T).new(nil) if a.nil? && b.nil?
    return b.not_nil! if a.nil? || a.value.nil?
    return a.not_nil! if b.nil? || b.value.nil?
    a, b = [a, b].sort_by(&.value.not_nil!)
    a.right = Heap.meld(a.right, b)
    a.right, a.left = a.left, a.right
    a
  end
end

class PriorityQueue(T)
  property size : Int32

  def initialize
    @heap = Heap(T).new(nil)
    @size = 0
  end

  def <<(value : T)
    push(value)
  end

  def push(value : T)
    @heap = Heap.meld(@heap, Heap.new(value))
    @size += 1
  end

  def pop
    ret = @heap.value
    @heap = Heap.meld(@heap.right, @heap.left)
    @size -= 1 unless ret.nil?
    ret
  end
end
