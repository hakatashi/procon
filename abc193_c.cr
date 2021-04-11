n = read_line.to_i64
i = 2_i64
set = Set(Int64).new
until i * i > n
  j = 2_i64
  loop do
    if i ** j <= n
      set << i ** j
    end
    break if n // (i ** j) < i
    j += 1
  end
  i += 1
end
p n - set.size