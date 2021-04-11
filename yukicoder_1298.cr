lib C;fun strtoll(s: UInt8*,p: UInt8**,b: Int32): Int64;end
class String;def to_i64;C.strtoll(self,nil,10);end;end

n = read_line.to_i64
if n.popcount == 1
  puts "-1 -1 -1"
  exit
end
a, b, c = 0_i64, 0_i64, 0_i64
64_i64.times do |i|
  if n.bit(i) == 1
    if a == 0
      a |= 1_i64 << i
      c |= 1_i64 << i
    else
      b |= 1_i64 << i
      c |= 1_i64 << i
    end
  end
end
puts "#{a} #{b} #{c}"
