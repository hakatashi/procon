n = read_line.to_i64
s = read_line
t = read_line

unpaired_index = nil.as(Nil | Int64)
unprocessed_ones = Deque(Int64).new
ans = 0_i64
n.times do |i|
  sc = s[i]
  tc = t[i]

  if tc == '1'
    unprocessed_ones << i.to_i64
  end

  if sc == '1'
    if unpaired_index.nil?
      if unprocessed_ones.empty?
        unpaired_index = i.to_i64
      else
        target = unprocessed_ones.shift
        ans += i - target
      end
    else
      ans += i - unpaired_index
      unpaired_index = nil
    end
  end
end

unless unprocessed_ones.empty? && unpaired_index.nil?
  p -1
else
  p ans
end
