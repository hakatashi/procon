n = read_line.to_i64
reds = [] of Int64
blues = [] of Int64
n.times do
  rx, c = read_line.split
  x = rx.to_i64
  if c == "R"
    reds << x
  else
    blues << x
  end
end
reds.sort!.each { |red| p red }
blues.sort!.each { |blue| p blue }
