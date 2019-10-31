# UnionFindTree.cr by Koki Takahashi
# Licensed under MIT License

class UnionFindTree
  property parents : Array(Int32)
  property sizes : Array(Int32)

  def initialize(size)
    @parents = Array.new(size, &.to_i32)
    @sizes = Array.new(size, 1)
  end

  def root(node)
    until @parents[node] == node
      @parents[node] = @parents[@parents[node]]
      node = @parents[node]
    end
    node
  end

  def unite(a, b)
    root_a = root(a)
    root_b = root(b)
    unless root_a == root_b
      if @sizes[root_a] < @sizes[root_b]
        root_a, root_b = root_b, root_a
      end
      @parents[root_b] = root_a
      @sizes[root_a] += @sizes[root_b]
    end
  end

  def same(a, b)
    root(a) == root(b)
  end

  def size(node)
    @sizes[root(node)]
  end
end


n, m = read_line.split.map(&.to_i)
queries = Array(Tuple(Int32, Int32)).new(m)
m.times do
  a, b = read_line.split.map(&.to_i)
  queries << {a - 1, b - 1}
end
ret = n.to_u64 * (n.to_u64 - 1) / 2
results = [] of UInt64
tree = UnionFindTree.new(n)
queries.reverse.each do |(a, b)|
  results << ret
  unless tree.same(a, b)
    ret -= tree.size(a) * tree.size(b)
    tree.unite(a, b)
  end
end
results.reverse.each do |result|
  p result
end