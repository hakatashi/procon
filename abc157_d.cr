# UnionFindTree.cr by Koki Takahashi
# Licensed under MIT License

class UnionFindTree
  property parents : Array(Int64)
  property sizes : Array(Int64)

  def initialize(size)
    @parents = Array.new(size, &.to_i64)
    @sizes = Array.new(size, 1_i64)
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

n, m, k = read_line.split.map(&.to_i64)
friends = [] of Tuple(Int64, Int64)
blocks = [] of Tuple(Int64, Int64)
m.times do
  a, b = read_line.split.map(&.to_i64)
  friends << {a - 1, b - 1}
end
k.times do
  c, d = read_line.split.map(&.to_i64)
  blocks << {c - 1, d - 1}
end

tree = UnionFindTree.new(n)
friends.each do |(a, b)|
  tree.unite(a, b)
end
friend_candidates = Array(Int64).new(n) do |i|
  tree.size(i).to_i64 - 1
end
friends.each do |(a, b)|
  friend_candidates[a] -= 1
  friend_candidates[b] -= 1
end
blocks.each do |(c, d)|
  if tree.same(c, d)
    friend_candidates[c] -= 1
    friend_candidates[d] -= 1
  end
end
puts friend_candidates.join(" ")