# -*- contest: language-test-202001 -*-

a = read_line.to_i64
b = read_line.to_i64
c = read_line.to_i64
x = read_line.to_i64
ans = 0_i64
0.upto(a) do |i|
  0.upto(b) do |j|
    0.upto(c) do |k|
      if i * 500 + j * 100 + k * 50 == x
        ans += 1
      end
    end
  end
end
p ans
