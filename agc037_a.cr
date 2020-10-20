s = read_line
if s.size == 1
  puts 1
  exit
end
if s.size == 2
  if s[0] == s[1]
    puts 1
  else
    puts 2
  end
  exit
end
cs = s.chars.map(&.to_s)
ret = 0_u64
prev_token = ""
current_token = ""
cs.each_with_index do |c, i|
  current_token += c
  if prev_token != current_token
    prev_token, current_token = current_token, ""
    ret += 1

    if i == cs.size - 3
      tail = s[-2..-1].chars
      if prev_token == tail[0].to_s || tail[0] == tail[1]
        puts ret + 1
      else
        puts ret + 2
      end
      exit
    end

    if i == cs.size - 4
      tail = s[-3..-1].chars
      if prev_token == tail[0].to_s || tail[0] == tail[1] || tail[1] == tail[2]
        puts ret + 2
      else
        puts ret + 3
      end
      exit
    end
  end
end
