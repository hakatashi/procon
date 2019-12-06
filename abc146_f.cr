n, m = read_line.split.map(&.to_i)
s = read_line.reverse.chars
dp = Array(Int32).new(n + 1, -1)
dp[0] = 0
anchor = 0
next_anchor = 0
1.upto(n) do |i|
  next if s[i] == '1'
  if anchor < i - m
    if next_anchor < i - m
      p -1
      exit
    end
    dp[i] = next_anchor
    anchor = next_anchor
  else
    dp[i] = anchor
  end
  next_anchor = i
end
ret = [] of Int32
ptr = n
until ptr == 0
  prev = dp[ptr]
  ret << ptr - prev
  ptr = prev
end
puts ret.join(' ')