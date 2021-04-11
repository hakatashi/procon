t = read_line.to_i64
t.times do
  n = read_line.to_i64
  s1 = read_line.chars
  s2 = read_line.chars
  s3 = read_line.chars
  v1 = s1.last.to_i * 2 + s1.first.to_i
  v2 = s2.last.to_i * 2 + s2.first.to_i
  v3 = s3.last.to_i * 2 + s3.first.to_i

  rem = (Set{0, 1, 2, 3} - Set{v1, v2, v3}).to_a[0]
  if rem == 0
    puts "0" * n + "1" + "0" * n
  elsif rem == 1
    puts "0" + "1" * n + "0" * n
  elsif rem == 2
    puts "0" * n + "1" * n + "0"
  elsif rem == 3
    puts "1" * n + "0" + "1" * n
  end
end
