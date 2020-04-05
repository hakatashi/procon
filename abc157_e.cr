# SegmentTree.cr by Koki Takahashi
# Licensed under MIT License

class SegmentTree(T)
  property values : Array(T)

  def initialize(values : Array(T))
    initialize(values) {|a, b| a > b ? a : b}
  end

  def initialize(values : Array(T))
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
        @segments[i] = child1 | child2
      elsif !child1.nil? && child2.nil?
        @segments[i] = child1
      end
    end
  end

  @[AlwaysInline]
  def []=(index : Int, value : T)
    @values[index] = value

    child = value
    parent_index = (index + @segments.size - 2) // 2
    while parent_index >= 0
      i = parent_index
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
        @segments[i] = child1 | child2
      elsif !child1.nil? && child2.nil?
        @segments[i] = child1
      end
      parent_index = (parent_index - 1) // 2
    end
  end

  @[AlwaysInline]
  def [](index : Int)
    @values[index]
  end

  @[AlwaysInline]
  def [](range : Range(Int, Int))
    a = range.begin
    b = range.exclusive? ? range.end : range.end + 1
    get_value(a, b, 0, 0, @segments.size).not_nil!
  end

  @[AlwaysInline]
  def get_value(a : Int, b : Int, segment_index : Int, range_begin : Int, range_end : Int)
    if range_end <= a || b <= range_begin
      return nil
    end
    if a <= range_begin && range_end <= b
      if segment_index + 1 < @segments.size
        return @segments[segment_index]
      else
        return @values[segment_index + 1 - @segments.size]
      end
    end
    range_median = (range_begin + range_end) // 2
    child1 = get_value(a, b, 2 * segment_index + 1, range_begin, range_median)
    child2 = get_value(a, b, 2 * segment_index + 2, range_median, range_end)
    if !child1.nil? && !child2.nil?
      child1 | child2
    elsif !child1.nil? && child2.nil?
      child1
    elsif child1.nil? && !child2.nil?
      child2
    else
      nil
    end
  end
end

n = read_line.to_i64
s = read_line.chars
q = read_line.to_i64
queries = [] of Tuple(String, String, String)
q.times do
  type, a, b = read_line.split
  queries << {type, a, b}
end

tree = SegmentTree(Int64).new(s.map {|c| 1_i64 << (c.ord - 97)})

queries.each do |(type, a, b)|
  if type == "1"
    i = a.to_i64 - 1
    c = b[0]
    next if s[i] == c
    tree[i] = 1_i64 << (c.ord - 97)
    s[i] = c
  elsif type == "2"
    l = a.to_i64 - 1
    r = b.to_i64 - 1
    ans = tree[l..r].popcount
    p ans
  end
end
