# SegmentTree.cr by Koki Takahashi
# Licensed under MIT License

class SegmentTree(T)
  property values : Array(T)

  def initialize(values : Array(T))
    initialize(values) { |a, b| a > b ? a : b }
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
    parent_index = (index + @segments.size - 2) // 2
    while parent_index >= 0
      child = @segments[parent_index] = @compare_proc.call(child, @segments[parent_index].not_nil!)
      parent_index = (parent_index - 1) // 2
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
    range_median = (range.begin + range.end) // 2
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

  def find(v : T)
    find_value(0, v)
  end

  def find_value(segment_index : Int, v : T)
    if 2 * segment_index + 2 >= @segments.size
      index = 2 * segment_index + 2 - @segments.size
      if @values.size <= index + 1 || @values[index] == v
        index
      else
        index + 1
      end
    elsif @segments[2 * segment_index + 1] == v
      find_value(2 * segment_index + 1, v)
    elsif @segments[2 * segment_index + 2] == v
      find_value(2 * segment_index + 2, v)
    else
      nil
    end
  end
end

n = read_line.to_i64
ais = read_line.split.map(&.to_i64)

counts = Array(Int64).new(n, 0_i64)
ais.each do |a|
  counts[a - 1] += 1
end

n.times do |i|
  perm = (0...n).to_a.select { |v| v != i }
  ans = [] of Int64
  ans << i
  tree = SegmentTree(Int64).new(counts)

  (n - 1).times do |j|
    tree[ais[ans.last] - 1] = tree[ais[ans.last] - 1] - 1
    if n - j - 2 >= 2 && tree[0...n] == n - j - 2
      take = tree.find(n - j - 2).not_nil!
      ans << take.to_i64
      perm.delete(take)
    else
      take = perm.index { |v| v != ais[ans.last] - 1 }
      if take.nil?
        break
      else
        ans << perm[take].to_i64
        perm.delete_at(take)
      end
    end
  end

  if ans.size == n
    puts ans.map { |v| v + 1 }.join(" ")
    exit
  end
end

p -1
