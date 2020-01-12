n, m = read_line.split.map(&.to_i)
cnts = Array(Int32).new(n, 0)
acs = Set(Int32).new
was = 0
m.times do
  rp, s = read_line.split
  pp = rp.to_i - 1
  if s == "WA"
    cnts[pp] += 1
  else
    unless acs.includes?(pp)
      was += cnts[pp]
      acs << pp
    end
  end
end
puts "#{acs.size} #{was}"