n = read_line.to_i64
tokens = [] of Tuple(Int64, Int64)
opens_sum = 0_i64
closes_sum = 0_i64

n.times do
  s = read_line
  cnt = 0_i64
  min = s.chars.min_of do |c|
    if c == '('
      cnt += 1
      opens_sum += 1
    else
      cnt -= 1
      closes_sum += 1
    end
    cnt
  end
  cnt = 0_i64
  max = s.chars.reverse_each.min_of do |c|
    if c == ')'
      cnt += 1
    else
      cnt -= 1
    end
    cnt
  end
  tokens << {
    min < 0 ? min.abs : 0_i64,
    max < 0 ? max.abs : 0_i64,
  }
end

if opens_sum != closes_sum
  puts "No"
  exit
end

opens = Array(Tuple(Int64, Int64)).new(n)
closes = Array(Tuple(Int64, Int64)).new(n)
evens = Array(Tuple(Int64, Int64)).new(n)
tokens.each do |token|
  close, open = token
  if close < open
    opens << token
  elsif close == open
    evens << token
  else
    closes << token
  end
end

depth = 0_i64
opens.sort_by! { |(close, open)| close }.each do |(close, open)|
  if close > depth
    puts "No"
    exit
  end
  depth += open - close
end

if evens.any? { |(close, open)| close > depth }
  puts "No"
  exit
end

depth = 0_i64
closes.sort_by! { |(close, open)| open }.each do |(close, open)|
  if open > depth
    puts "No"
    exit
  end
  depth += close - open
end

puts "Yes"
