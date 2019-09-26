class SegmentTree(T)
  property values : Array(T)

  def initialize(values : Array(T))
    initialize(values) {|a, b| [a, b].max}
  end

  def initialize(values : Array(T), &block : T, T -> T)
    @compare_proc = block
    @values = values
    @segments = Array(T | Nil).new(2 ** Math.log2(values.size).ceil.to_i, nil)

    # initialize segments
    (@segments.size - 2).downto(0) do |i|
      child1 = nil.as(T | Nil)
      child2 = nil.as(T | Nil)
      if i * 2 + 2 < @segments.size
        child1 = @segments[i * 2 + 1]
        child2 = @segments[i * 2 + 2]
      else
        if i * 2 + 2 - @segments.size < @values.size
          child1 = @values[i * 2 + 2 - @segments.size]
        end
        if i * 2 + 3 - @segments.size < @values.size
          child2 = @values[i * 2 + 3 - @segments.size]
        end
      end
      if !child1.nil? && !child2.nil?
        @segments[i] = @compare_proc.call(child1, child2)
      elsif !child1.nil? && child2.nil?
        @segments[i] = child1
      end
    end
  end

  def []=(index : Int, value : T)
    @values[index] = value

    child = value
    parent_index = (index + @segments.size - 2) / 2
    while parent_index >= 0
      child = @segments[parent_index] = @compare_proc.call(child, @segments[parent_index].not_nil!)
      parent_index = (parent_index - 1) / 2
    end
  end

  def [](index : Int)
    @values[index]
  end

  def [](range : Range(Int, Int))
    a = range.begin
    b = range.exclusive? ? range.end : range.end + 1
    get_value(a, b, 0, 0...@segments.size).not_nil!
  end

  def get_value(a : Int, b : Int, segment_index : Int, range : Range(Int, Int))
    if range.end <= a || b <= range.begin
      return nil
    end
    if a <= range.begin && range.end <= b
      if segment_index + 1 < @segments.size
        return @segments[segment_index]
      else
        return @values[segment_index + 1 - @segments.size]
      end
    end
    range_median = (range.begin + range.end) / 2
    child1 = get_value(a, b, 2 * segment_index + 1, range.begin...range_median)
    child2 = get_value(a, b, 2 * segment_index + 2, range_median...range.end)
    if !child1.nil? && !child2.nil?
      @compare_proc.call(child1, child2)
    elsif !child1.nil? && child2.nil?
      child1
    elsif child1.nil? && !child2.nil?
      child2
    else
      nil
    end
  end
end


n, k = read_line.split.map(&.to_u64)
ps = read_line.split.map(&.to_u64)

min_segtree = SegmentTree.new(ps) {|a, b| a < b ? a : b}
max_segtree = SegmentTree.new(ps) {|a, b| a > b ? a : b}

last_unsorted = -1

ret = 1_u64
k.times do |i|
  if i >= 1
    if ps[i - 1] > ps[i]
      last_unsorted = i - 1
    end
  end
end

sorted = 0
if last_unsorted == -1
  sorted += 1
end

k.upto(n - 1) do |i|
  v = ps[i]
  pv = ps[i - k]

  if ps[i - 1] > ps[i]
    last_unsorted = i - 1
  end

  unless pv < min_segtree[(i - k + 1)...i] && max_segtree[(i - k + 1)...i] < v
    if i - last_unsorted >= k
      sorted += 1
    end
    ret += 1
  end
end

if sorted >= 2
  p ret - sorted + 1
else
  p ret
end
