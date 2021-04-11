gets
pes = read_line.split.map(&.to_i64)
queue = Array(Int64).new(pes.size)
visited = Set(Int64).new
ans = Array(Int64).new(pes.size)
pes.each do |pe|
  i = queue.bsearch_index {|j| j > pe}
  if i.nil?
    i = queue.size
  end
  (queue.size.to_i64 - 1).downto(i.to_i64) do |j|
    if visited.includes?(j)
      p -1
      exit
    end
    visited << j
    ans << j
  end
  queue.insert(i, pe)
end
if ans.size != pes.size - 1
  p -1
  exit
end
ans.each do |a|
  p a + 1
end