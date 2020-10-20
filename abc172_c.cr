def max(a, b)
  a > b ? a : b
end

n, m, k = read_line.split.map(&.to_i64)
ais = Deque(Int64).new(read_line.split.map(&.to_i64))
bs = Deque(Int64).new(read_line.split.map(&.to_i64))

tmp = 0_i64
cnt = 0_i64
stack = Deque(Int64).new
while !ais.empty? && tmp + ais.first <= k
  a = ais.shift
  stack << a
  tmp += a
  cnt += 1
end
while !bs.empty? && tmp + bs.first <= k
  tmp += bs.shift
  cnt += 1
end
ans = cnt
while !stack.empty?
  tmp -= stack.pop
  cnt -= 1
  while !bs.empty? && tmp + bs.first <= k
    tmp += bs.shift
    cnt += 1
  end
  ans = max(cnt, ans)
end
p ans
