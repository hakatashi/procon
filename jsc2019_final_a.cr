# -*- contest: jsc2019-final-open -*-

gets
ais = read_line.split.map(&.to_i)
bs = read_line.split.map(&.to_i)

hash = Hash(Int32, Tuple(Int32, Int32)).new

ais.each_with_index do |a, ai|
  bs.each_with_index do |b, bi|
    if hash.has_key? a + b
      puts "#{hash[a + b][0]} #{hash[a + b][1]} #{ai} #{bi}"
      exit
    end
    hash[a + b] = {ai, bi}
  end
end

p -1
