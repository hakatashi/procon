gets
ais = read_line.split.map(&.to_i64)
xor = ais[2..].reduce(0_i64) {|a, b| a ^ b}
a, b = ais[0], ais[1]
sum = a + b
carry = false
pattern = [] of Int64
40_i64.downto(0_i64) do |i|
  xor_bit = (xor >> i) & 1_i64
  sum_bit = (sum >> i) & 1_i64
  if xor_bit == 0 && sum_bit == 0
    if carry
      pattern << 1
      carry = false
    else
      pattern << 0
    end
  elsif xor_bit == 0 && sum_bit == 1
    if carry
      pattern << 1
    else
      pattern << 0
      carry = true
    end
  elsif xor_bit == 1 && sum_bit == 0
    if carry
      pattern << 2
    else
      p -1
      exit
    end
  elsif xor_bit == 1 && sum_bit == 1
    if carry
      p -1
      exit
    else
      pattern << 2
    end
  end
end
first_miss = nil.as(Int64 | Nil)
40_i64.downto(0_i64) do |i|
  target_bit = (b >> i) & 1_i64
  pattern_bit = pattern[40 - i]
  if pattern_bit == 0 && target_bit == 1
    first_miss = i
    break
  end
end
fixed = -1_i64
40_i64.downto(first_miss.nil? ? 0_i64 : first_miss) do |i|
  target_bit = (b >> i) & 1_i64
  pattern_bit = pattern[40 - i]
  if pattern_bit == 1 && target_bit == 0
    fixed = i
    break
  elsif pattern_bit == 2 && target_bit == 0
    pattern[40 - i] = 1
    fixed = i
    break
  end
end
if fixed == -1
  p -1
  exit
end
40_i64.downto(0_i64) do |i|
  target_bit = (b >> i) & 1_i64
  pattern_bit = pattern[40 - i]
  if pattern_bit == 2
    if i > fixed
      pattern[40 - i] = target_bit
    else
      pattern[40 - i] = 0_i64
    end
  end
end
target_b = pattern.join.to_i64(2)
if target_b == sum
  p -1
  exit
end
p target_b - b
