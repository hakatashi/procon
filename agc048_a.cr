t = read_line.to_i64
t.times do
  s = read_line.chars
  ans = [] of Int64
  ret = 0_i64
  "atcoder".chars.each_with_index do |c, i|
    j = s.index { |sc| sc >= c }
    k = s.index { |sc| sc > c }
    if j.nil?
      ret = -1_i64
      break
    else
      unless k.nil?
        ans << ret + k
      end
      if s[j] > c
        break
      end
      ret += j
      s.delete_at(j)
      if i == 6 && !s.empty?
        ans << ret
      end
    end
  end
  p ans.empty? ? -1 : ans.min
end
