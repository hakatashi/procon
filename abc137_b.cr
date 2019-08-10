k, x = read_line.split.map(&.to_i64)
ret = Array(Int64).new
(x - k + 1).upto(x + k - 1) do |i|
  ret << i
end
puts ret.join(" ")
