n, k = read_line.split.map(&.to_i64)
adjs = Array(Set(Int32)).new
n.times do
  adjs << Set(Int32).new
end
STDIN.gets_to_end.lines.each do |l|
  a, b = l.split.map(&.to_i32)
  adjs[a - 1] << b - 1
  adjs[b - 1] << a - 1
end
def search_by(node : Int32, parent : Int32, depth : Int32, adjs : Array(Set(Int32)), k : Int64)
  ret = 1_i64
  if depth >= 1
    i = 2_i64
  else
    i = 1_i64
  end
  adjs[node].each do |adj|
    if adj != parent
      if i >= k
        return 0
      end
      n = search_by(adj, node, depth + 1, adjs, k)
      ret = (ret * n * (k - i)) % 1000000007
      i += 1
    end
  end
  return ret
end
puts (search_by(0, -1, 0, adjs, k) * k) % 1000000007
