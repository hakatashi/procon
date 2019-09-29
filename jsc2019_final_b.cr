# -*- contest: jsc2019-final-open -*-

n = read_line.to_i
aiss = Array(Array(Char)).new
bss = Array(Array(Char)).new

n.times do
  aiss << read_line.chars
end
n.times do
  bss << read_line.chars
end

css = Array(Array(Char)).new(n) { Array(Char).new(n) { '1' } }

aiss.each_with_index do |ais, i|
  ais.each_with_index do |a, j|
    if a == '1'
      bss[i].each_with_index do |b, k|
        if b == '0'
          css[j][k] = '0'
        end
      end
    end
  end
end

bss.each_with_index do |bs, i|
  bs.each_with_index do |b, j|
    if b == '1'
      pass = false
      n.times do |k|
        if aiss[i][k] == '1' && css[k][j] == '1'
          pass = true
          break
        end
      end
      unless pass
        p -1
        exit
      end
    end
  end
end

css.each do |cs|
  puts cs.join
end
