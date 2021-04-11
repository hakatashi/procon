n, m = read_line.split.map(&.to_i64)
ais = read_line.split.map(&.to_i64).sort!

cur = 0_i64
chunks = Array(Int64).new(ais.size)
ais.each do |a|
  chunks << a - cur - 1
  cur = a
end
chunks << n - cur

chunks.select! {|chunk| chunk > 0}

if chunks.size == 0
  p 0
  exit
end

min_chunk = chunks.min

ans = 0_i64
chunks.each do |chunk|
  ans += (chunk + min_chunk - 1) // min_chunk
end
p ans
