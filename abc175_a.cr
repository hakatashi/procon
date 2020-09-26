s = read_line
if s == "RRR"
  p 3
elsif s == "SSS"
  p 0
elsif (s[0] == 'R' && s[1] == 'R') || (s[1] == 'R' && s[2] == 'R')
  p 2
else
  p 1
end