n = read_line.to_i64
hash = Hash(String, Bool).new
n.times do
  s = read_line
  if s.starts_with?("!")
    s = s[1..]
    b = false
  else
    b = true
  end

  if hash.has_key?(s)
    if hash[s] != b
      puts s
      exit
    end
  else
    hash[s] = b
  end
end
puts "satisfiable"
