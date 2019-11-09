# SegmentTree.cr by Koki Takahashi
# Licensed under MIT License

class SegmentTree(T)
  property values : Array(T)

  def initialize(values : Array(T))
    initialize(values) {|a, b| a > b ? a : b}
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


INF = 100000000000000_u64

n, m = read_line.split.map(&.to_i)
bars = [] of Tuple(Int32, Int32, Int32)
m.times do
  l, r, c = read_line.split.map(&.to_i)
  bars << {l, r, c}
end
unless bars.any? {|(l, r, c)| r == n}
  p -1
  exit
end
r_to_index = Hash(Int32, Int32).new
uniq_rs = (bars.map {|(l, r, c)| r} + [1]).uniq.sort
uniq_rs.each_with_index do |r, i|
  r_to_index[r] = i
end
segtree = SegmentTree.new(Array(UInt64).new(uniq_rs.size + 1, INF)) {|a, b| a < b ? a : b}
segtree[0] = 0_u64

bars.sort_by {|(l, r, c)| r}.each do |(l, r, c)|
  to = r_to_index[r]
  from = uniq_rs.bsearch_index {|r| r >= l}.not_nil!
  if from == to
    next
  end
  if segtree[to] == INF
    segtree[to] = segtree[from...to] == INF ? INF : segtree[from...to] + c
  else
    before = segtree[to]
    after = segtree[from...to] == INF ? INF : segtree[from...to] + c
    if before > after
      segtree[to] = after
    end
  end
end
if segtree[uniq_rs.size - 1] == INF
  p -1
else
  p segtree[uniq_rs.size - 1]
end
